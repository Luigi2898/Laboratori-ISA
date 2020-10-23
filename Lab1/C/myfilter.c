#include <stdio.h>
#include <stdlib.h>

#define NT 9  /// number of coeffs
#define NB 11 /// number of bits
#define NI 10

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

/// Perform fixed point filtering assming direct form I
///\param x is the new input sample
///\return the new output sample
int myfilter(int x)
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
  {
    y += (sx[i] * b[i]) >> (NB - 1);
  }

  /// Auto regressive part
  //for (i = 0; i < NT - 1; i++)
  //y -= (sy[i] * a[i]) >> (NB - 1);

  /*/// update the y shift register
  for (i = NT - 2; i > 0; i--)
    sy[i] = sy[i - 1];
  sy[0] = y * 2 * 2;*/
  return y;
}

int main(int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;
  int cnt;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n");
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  cnt = 0;
  do
  {
    cnt++;
    y = myfilter(x);
    if (cnt > NT - 1)
      fprintf(fp_out, "%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;
}
