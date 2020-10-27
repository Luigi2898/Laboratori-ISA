#include <stdio.h>
#include <stdlib.h>

#define NT 9  /// number of coeffs
#define NB 11 /// number of bits
#define NI 10
#define NF 3 // unfolding degree

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

/// Perform fixed point filtering assming direct form I
///\param x is the new input sample
///\return the new output sample
int myfilter(int x)
{
  static int sx[NT+2];        /// x shift register
  static int sy[NT - 1];    /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i;                    /// index
  int y,y0,y1,y2;                    /// output sample
  int tmp0,tmp1,tmp2;       /// partial products
  int state_rdy = 0;           ///state ready flag
  int state_x[NF];

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT+1; i++)
      sx[i] = 0;
    //for (i = 0; i < NT - 1; i++)
      //sy[i] = 0;
  }


  ///wait to acquire 3 samples before starting

  state_x[state_rdy] = x;
  x += 1;

  if (state_rdy == 3){
      state_rdy = 0;
    /// shift and insert new sample in x shift register
    for (i = NT + 1; i > 0; i--)
        sx[3*i+2] = sx[3*(i-1)+2];
        sx[3*i+1] = sx[3*(i-1)+1];
        sx[3*i] = sx[3*(i-1)];
    sx[0] = state_x[2];
    sx[1] = state_x[1];
    sx[2] = state_x[0];
    /// make the convolution
    /// Moving average part
    y = 0;
    for (i = 0; i < NT; i++)
    {
        tmp0 = (sx[i+2] * b[i]) >> (NB - 1);
        tmp1 = (sx[i+1] * b[i]) >> (NB - 1);
        tmp2 = (sx[i+0] * b[i]) >> (NB - 1);
        y0 += tmp0;
        y1 += tmp1;
        y2 += tmp2;
        //printf("%d\n", tmp);
    }
    y = y0+y1+y2:

    printf("----------------------\n\n");
    /// Auto regressive part
    //for (i = 0; i < NT - 1; i++)
    //y -= (sy[i] * a[i]) >> (NB - 1);

    /*/// update the y shift register
    for (i = NT - 2; i > 0; i--)
        sy[i] = sy[i - 1];
    sy[0] = y * 2 * 2;*/
    return y;
    }
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
  do
  {
    y = myfilter(x);
    fprintf(fp_out, "%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;
}
