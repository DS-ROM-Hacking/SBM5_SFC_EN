#include <iostream>
#include <fstream>
#include <iomanip>

using namespace std;

struct backref_t {

	uint16_t length, distance;

};

const int BUFFER_SIZE = 65536;
const int MAX_MATCH_LENGTH = 32;
const int MIN_MATCH_LENGTH = 1;
const int MAX_RAW_LENGTH = 32;
const int D = 6;

char _distanceData[D] = { 1, 2, 4, 16, 32, 64 };

backref_t search_backref(int pos, char* buffer, int inputsize);
backref_t search_incr(int pos, char* buffer, int inputsize);
void write_backref(char *out, int out_pos, backref_t backref);
void write_raw(char *out, int out_pos, char *in, int insize);
void write_incrref(char *out, int out_pos, backref_t backref);

int main() {

	cout << "--===Super Bomberman 5===---" << endl;

	char _inputData[BUFFER_SIZE] = { 0 };
	char _outputData[BUFFER_SIZE] = { 0 };
	char _tempData[BUFFER_SIZE] = { 0 };
	char _rawData[MAX_RAW_LENGTH];
	int _rawLength = 0;

	int _inputPosition = 0x40;
	int _outputPosition = 0;
	int _inputSize = 0;

	ifstream _inputFile("sbm5_game_pointer_0x05e524_decomp.bin",
			ios::in | ios::binary);

	if (!_inputFile.is_open()) {
		cout << "FILE_OPEN_ERROR\n";
	} else {
		_inputFile.seekg(0, ios::end);
		_inputSize = _inputFile.tellg();
		cout << hex << "Input size=[" << int(_inputSize) << "]" << endl;

		const int _newSize = _inputSize + 0x40;

		_inputFile.seekg(0, ios::beg);
		_inputFile.read(_tempData, _inputSize);
		_inputFile.close();

		for (int i = 0x40, j = 0; i < _newSize; i++, j++) {
			_inputData[i] = _tempData[j];
		}

		backref_t backref = { 0, 0 };
		backref_t incrref = { 0, 0 };

		cout << hex << "Starting compression...";

		while (_inputPosition < _newSize) {

			cout << hex << "\nIn_pos=[" << setw(4)
					<< (int) _inputPosition - 0x40 << "]";
			cout << hex << " Out_pos=[" << setw(4) << (int) _outputPosition
					<< "]";

			backref = search_backref(_inputPosition, _inputData, _newSize);
			incrref = search_incr(_inputPosition, _inputData, _newSize);

			if (incrref.length > backref.length || (incrref.length >= _rawLength && incrref.length >= MIN_MATCH_LENGTH)
					//&& incrref.length > MIN_MATCH_LENGTH)
					//|| (incrref.length < _rawLength
					//		&& incrref.length > MIN_MATCH_LENGTH)
					//|| (incrref.length > _rawLength && incrref.length > MIN_MATCH_LENGTH)
					) {

				cout << " WRITE_INCRREF";

				if (_rawLength > 0) {
					cout << ", WRITE_RAW_FIRST";
					write_raw(_outputData, _outputPosition, _rawData,
							_rawLength);
					_outputPosition += (_rawLength + 1);
					_rawLength = 0;
				}

				write_incrref(_outputData, _outputPosition, incrref);

				_inputPosition += incrref.length;
				_outputPosition++;

			}

			else {

				if (backref.length > _rawLength
						|| backref.length > MIN_MATCH_LENGTH
						|| (backref.length < _rawLength
								&& backref.length > MIN_MATCH_LENGTH)

						) {
					cout << " WRITE_BACKREF";

					if (_rawLength > 0) {
						cout << ", WRITE_RAW_FIRST";
						write_raw(_outputData, _outputPosition, _rawData,
								_rawLength);
						_outputPosition += (_rawLength + 1);
						_rawLength = 0;
					}

					write_backref(_outputData, _outputPosition, backref);

					_inputPosition += backref.length;
					_outputPosition++;

				} else {
					_rawData[_rawLength++] = _inputData[_inputPosition++];
					cout << hex << " RAW_LENGTH=[" << (int) _rawLength << "]";

					if (_rawLength == MAX_RAW_LENGTH) {
						cout << " WRITE_RAW";
						write_raw(_outputData, _outputPosition, _rawData,
								_rawLength);
						_inputPosition += _rawLength;
						int plus = _rawLength + 1;
						_outputPosition += plus;
						_rawLength = 0;
					}
				}

			}

		}

		if (_rawLength > 0) {
			cout << " WRITE_RAW";
			write_raw(_outputData, _outputPosition, _rawData, _rawLength);
			_inputPosition += _rawLength;
			int plus = _rawLength + 1;
			_outputPosition += plus;
			_rawLength = 0;

		}

		ofstream _outputFile("sbm5_comp.bin", ios::out | ios::binary);
		if (!_outputFile.is_open())

		{
			cout << "FILE_OPEN_ERROR!!!\n";
		}

		else {
			_outputFile.write(_outputData, _outputPosition);
			_outputFile.close();
		}

	}

	return 0;

}

backref_t search_backref(int pos, char* buffer, int inputsize) {

	backref_t variant = { 0, 0 };
	int match = 0;

	int backref_len = 0;
	int backref_dist = 0;

	int searchPosition = 0;

	for (int idx = 0; idx < D; idx++) {

		searchPosition = pos - _distanceData[idx];
		if ((buffer[searchPosition] == buffer[pos])) {
			match = 1;

			while ((buffer[searchPosition + match] == buffer[pos + match])
					&& (pos + match < inputsize)
					&& ((searchPosition + MAX_MATCH_LENGTH)
							< (pos + MAX_MATCH_LENGTH))) {

				if (match >= MAX_MATCH_LENGTH) {
					break;
				}
				match++;
			}

			if (match > backref_len) {
				backref_len = match;
				backref_dist = _distanceData[idx];
			}
		}

	}

	variant.length = backref_len;
	variant.distance = backref_dist;
	cout << hex << " len=[" << setw(4) << (int) variant.length << "]";
	cout << hex << " dist=[" << setw(4) << (int) variant.distance << "]";

	return variant;
}

backref_t search_incr(int pos, char* buffer, int inputsize) {

	backref_t variant = { 0, 0 };
	int match = 0;

	int backref_len = 0;

	int searchPosition = 0;

	int i = 1;
	searchPosition = pos - 1;
	//int c = buffer[searchPosition]+i;
	int c = buffer[searchPosition];
	int n = buffer[searchPosition] + 1;
	cout << hex << " c=[" << setw(4) << (int) c << "]";
	cout << hex << " n=[" << setw(4) << (int) n << "]";

	//for(i=0;i<MAX_MATCH_LENGTH;i++)
	//{
	cout << hex << " i=[" << setw(4) << (int) i << "]";
	//if (buffer[pos+i] == (buffer[searchPosition]+i)) {
	//if (buffer[pos] == (buffer[searchPosition]+i)) {
	if (buffer[pos] == n) {

		match = 1;
		cout << hex << " match1=[" << setw(4) << (int) match << "]";

		while (buffer[pos + match] == (n + match)) {

			if (match >= MAX_MATCH_LENGTH) {
				break;
			}
			match++;

			cout << hex << " match2=[" << setw(4) << (int) match << "]";
		}

		if (match > backref_len) {
			backref_len = match;
		}
	}

//			else
//			{
//				break;
//			}

	//}

	variant.length = backref_len;
	//variant.distance = backref_dist;
	cout << hex << " len=[" << setw(4) << (int) variant.length << "]";
	//cout << hex << " dist=[" << setw(4) << (int) variant.distance << "]";

	return variant;
}

void write_raw(char *out, int out_pos, char *in, int insize) {

	int size = insize - 1;
	out[out_pos++] = 0x00 | size;

	for (int i = 0; i < insize; i++) {
		out[out_pos++] = in[i];
	}

}

void write_backref(char *out, int out_pos, backref_t backref) {

	int size = backref.length - 1;

	switch (backref.distance) {
	case 1:
		out[out_pos] = 0x40 | size;
		break;
	case 2:
		out[out_pos] = 0x60 | size;
		break;
	case 4:
		out[out_pos] = 0x80 | size;
		break;
	case 16:
		out[out_pos] = 0xA0 | size;
		break;
	case 32:
		out[out_pos] = 0xC0 | size;
		break;
	case 64:
		out[out_pos] = 0xE0 | size;
		break;
	}

}

void write_incrref(char *out, int out_pos, backref_t backref) {

	int size = backref.length - 1;
	out[out_pos] = 0x20 | size;

}

