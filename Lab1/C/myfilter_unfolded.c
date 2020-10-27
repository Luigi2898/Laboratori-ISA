#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)
#define NT 9  /// number of coeffs
#define NB 11 /// number of bits
#define NI 10
#define NF 3 // unfolding degree

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

/// Perform fixed point filtering assming direct form I
///\param x is the new input sample
///\return the new output sample
void myfilter(int x0, int x1, int x2, int *y0, int *y1, int *y2)
{
  static int sx[NT+2];       /// x shift register
  static int sy[NT - 1];     /// y shift register
  static int first_run = 0;  /// for cleaning shift registers
  int i;                     /// index
  int tmp0[NT];              /// partial products - state 0
  int tmp1[NT];              /// partial products - state 1
  int tmp2[NT];              /// partial products - state 2
  static int state_x[NF];    /// special arrangement for different samples

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT+1; i++)
      sx[i] = 0;
    //for (i = 0; i < NT - 1; i++)
      //sy[i] = 0;
  }

    /// shift and insert new sample in x shift register
    for (i = 3; i > 0; i--) {
    if ((3 * i + 2) > 10) {}
    else {
        sx[3 * i + 2] = sx[3 * (i - 1) + 2];
    }
    sx[3 * i + 1] = sx[3 * (i - 1) + 1];
    sx[3 * i + 0] = sx[3 * (i - 1) + 0];
    }
    sx[0] = x2;
    sx[1] = x1;
    sx[2] = x0;

    /// make the convolution
    *y0 = 0;
    *y1 = 0;
    *y2 = 0;
    for (i = 0; i < NT; i++) {
        tmp0[i] = 0;
        tmp1[i] = 0;
        tmp2[i] = 0;
    }

    for (i = 0; i < NT; i++)
    {
    tmp0[i] = (sx[i + 2] * b[i]) >> (NB - 1);
    tmp1[i] = (sx[i + 1] * b[i]) >> (NB - 1);
    tmp2[i] = (sx[i + 0] * b[i]) >> (NB - 1);
    }

    for (i = 0; i < NT; i++) {
        *y0 += tmp0[i];
        *y1 += tmp1[i];
        *y2 += tmp2[i];
    }



    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");
      
    return;
}


int main(int argc, char **argv)
//int main ()
{
  FILE *fp_in;
  FILE *fp_out;

  int x0,x1,x2;
  int y0,y1,y2;
  int cnt;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  //fp_in = fopen("samples.txt", "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open file\n");
    exit(2);
  }
  fp_out = fopen(argv[2], "w");
  //fp_out = fopen("resultC_unfolded.txt", "w");

  /// get triplet of samples and apply filter unfolded
  fscanf(fp_in, "%d", &x0);
  fscanf(fp_in, "%d", &x1);
  fscanf(fp_in, "%d", &x2);

  do
  {
    myfilter(x0,x1,x2,&y0,&y1,&y2);
    fprintf(fp_out, "%d\n", y0);
    fprintf(fp_out, "%d\n", y1);
    fprintf(fp_out, "%d\n", y2);
    fscanf(fp_in, "%d", &x0);
    fscanf(fp_in, "%d", &x1);
    fscanf(fp_in, "%d", &x2);
  } 
  while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;
}
