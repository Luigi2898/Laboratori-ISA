#include <stdio.h>
#include <stdlib.h>

#define NT 9  /// number of coeffs
#define NB 11 /// number of bits
#define NB2 8 /// number of bits
#define NI 3

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

/// Perform fixed point filtering assming direct form I
///\param x is the new input sample
///\return the new output sample
// myfilter1 : everything processed with 8 msbits out of the 11 of data and coeffs
int myfilter1(int x)
{
  static int sx[NT];        /// x shift register
  static int sy[NT - 1];    /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i;                    /// index
  int y;                    /// output sample
  int tmp;

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT; i++)
      sx[i] = 0;
    for (i = 0; i < NT - 1; i++)
      sy[i] = 0;
  }

  /// shift and insert new sample in x shift register
  for (i = NT - 1; i > 0; i--)
    sx[i] = sx[i - 1];
  sx[0] = x >> NI;
  /// make the convolution
  /// Moving average part
  y = 0;
  for (i = 0; i < NT; i++)
    y += (sx[i] * (b[i] >> NI)) >> (NB2 - 1);
  y = y << NI;
  return y;
}
// myfilter2 : 8 bits truncated to 7 after multiplication
int myfilter2(int x)
{
  static int sx[NT];        /// x shift register
  static int sy[NT - 1];    /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i;                    /// index
  int y;                    /// output sample
  int tmp;

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT; i++)
      sx[i] = 0;
    for (i = 0; i < NT - 1; i++)
      sy[i] = 0;
  }

  /// shift and insert new sample in x shift register
  for (i = NT - 1; i > 0; i--)
    sx[i] = sx[i - 1];
  sx[0] = x >> NI;
  /// make the convolution
  /// Moving average part
  y = 0;
  for (i = 0; i < NT; i++)
    y += (sx[i] * (b[i] >> NI)) >> (NB2);
  y = y << (NI+1);
  return y;
}
// myfilter3 : 11 bits truncated to 8 after multiplication
int myfilter3(int x)
{
  static int sx[NT];        /// x shift register
  static int sy[NT - 1];    /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i;                    /// index
  int y;                    /// output sample
  int tmp;

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT; i++)
      sx[i] = 0;
    for (i = 0; i < NT - 1; i++)
      sy[i] = 0;
  }

  /// shift and insert new sample in x shift register
  for (i = NT - 1; i > 0; i--)
    sx[i] = sx[i - 1];
  sx[0] = x;
  /// make the convolution
  /// Moving average part
  y = 0;
  for (i = 0; i < NT; i++)
    y += (sx[i] * b[i]) >> (NB + 2);
  
  return y << NI;
}

int main(int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out1;
  FILE *fp_out2;
  FILE *fp_out3;

  int x;
  int y1;
  int y2;
  int y3;
  int cnt;

  /// check the command line
  if (argc != 5)
  {
    printf("Use: %s <input_file> <output_file1> <output_file2> <output_file3>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n");
    exit(2);
  }
  fp_out1 = fopen(argv[2], "w");
  fp_out2 = fopen(argv[3], "w");
  fp_out3 = fopen(argv[4], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do
  {
    y1 = myfilter1(x);
	y2 = myfilter2(x);
	y3 = myfilter3(x);
    fprintf(fp_out1, "%d\n", y1);
	fprintf(fp_out2, "%d\n", y2);
	fprintf(fp_out3, "%d\n", y3);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out1);
  fclose(fp_out2);
  fclose(fp_out3);

  return 0;
}
