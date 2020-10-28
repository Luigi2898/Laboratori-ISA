#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)
#define NT 9  /// number of coeffs
#define NB 11 /// number of bits myfilter1
#define NB2 8 /// number of bits myfilter2 my filter 3
#define NF 3 // unfolding degree

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

// myfilter1 : 11 bits truncated to 8 after multiplication
void myfilter1(int x0, int x1, int x2, int *y0, int *y1, int *y2)
{
  static int sx[NT+2];       /// x shift register
  static int first_run = 0;  /// for cleaning shift registers
  int i;                     /// index
  int tmp0[NT];              /// partial products - state 0
  int tmp1[NT];              /// partial products - state 1
  int tmp2[NT];              /// partial products - state 2
  int tmps0 = 0;              /// partial sum - state 0
  int tmps1 = 0;              /// partial sum - state 1
  int tmps2 = 0;              /// partial sum - state 2
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
    tmp0[i] = (sx[i + 2] * b[i]) >> (NB + 2);
    tmp1[i] = (sx[i + 1] * b[i]) >> (NB + 2);
    tmp2[i] = (sx[i + 0] * b[i]) >> (NB + 2);
    }


    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 3;
    *y1 = tmps1 << 3;
    *y2 = tmps2 << 3;
      
    return;
}

// myfilter2 : everything processed with 8 msbits out of the 11 of data and coeffs
void myfilter2(int x0, int x1, int x2, int* y0, int* y1, int* y2)
{
    static int sx[NT + 2];       /// x shift register
    static int first_run = 0;  /// for cleaning shift registers
    int i;                     /// index
    int tmp0[NT];              /// partial products - state 0
    int tmp1[NT];              /// partial products - state 1
    int tmp2[NT];              /// partial products - state 2
    int tmps0 = 0;              /// partial sum - state 0
    int tmps1 = 0;              /// partial sum - state 1
    int tmps2 = 0;              /// partial sum - state 2
    static int state_x[NF];    /// special arrangement for different samples

    /// clean the buffers
    if (first_run == 0)
    {
        first_run = 1;
        for (i = 0; i < NT + 1; i++)
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
    sx[0] = x2 >> 3;
    sx[1] = x1 >> 3;
    sx[2] = x0 >> 3;

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
        tmp0[i] = (sx[i + 2] * (b[i] >> 3)) >> (NB2 - 1);
        tmp1[i] = (sx[i + 1] * (b[i] >> 3)) >> (NB2 - 1);
        tmp2[i] = (sx[i + 0] * (b[i] >> 3)) >> (NB2 - 1);
    }

    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 3;
    *y1 = tmps1 << 3;
    *y2 = tmps2 << 3;

    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");

    return;
}

// myfilter3 : 8 bits truncated to 7 after multiplication
void myfilter3(int x0, int x1, int x2, int* y0, int* y1, int* y2)
{
    static int sx[NT + 2];       /// x shift register
    static int first_run = 0;  /// for cleaning shift registers
    int i;                     /// index
    int tmp0[NT];              /// partial products - state 0
    int tmp1[NT];              /// partial products - state 1
    int tmp2[NT];              /// partial products - state 2
    int tmps0 = 0;              /// partial sum - state 0
    int tmps1 = 0;              /// partial sum - state 1
    int tmps2 = 0;              /// partial sum - state 2
    static int state_x[NF];    /// special arrangement for different samples

    /// clean the buffers
    if (first_run == 0)
    {
        first_run = 1;
        for (i = 0; i < NT + 1; i++)
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
    sx[0] = x2 >> 3;
    sx[1] = x1 >> 3;
    sx[2] = x0 >> 3;

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
        tmp0[i] = (sx[i + 2] * (b[i] >> 3)) >> (NB2);
        tmp1[i] = (sx[i + 1] * (b[i] >> 3)) >> (NB2);
        tmp2[i] = (sx[i + 0] * (b[i] >> 3)) >> (NB2);
    }

    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 4;
    *y1 = tmps1 << 4;
    *y2 = tmps2 << 4;


    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");

    return;
}

//int main(int argc, char **argv)
int main ()
{
  FILE *fp_in;
  FILE *fp_out1,*fp_out2,*fp_out3;

  int x0,x1,x2;
  int y0,y1,y2;

  /// check the command line
  //if (argc != 3)
  //{
  //  printf("Use: %s <input_file> <output_file>\n", argv[0]);
  //  exit(1);
  //}

  /// open files
  //fp_in = fopen(argv[1], "r");
  fp_in = fopen("samples.txt", "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open file\n");
    exit(2);
  }
  //fp_out = fopen(argv[2], "w");
  fp_out1 = fopen("resultC_unfolded11then8.txt", "w");
  fp_out2 = fopen("resultC_unfolded8.txt", "w");
  fp_out3 = fopen("resultC_unfolded8then7.txt", "w");
  if ((fp_out1 == NULL) || (fp_out2 == NULL) || (fp_out3 == NULL))
  {
      printf("Error: cannot open one of the output files.\n");
      exit(3);
  }
  /// get triplet of samples and apply filter unfolded
  fscanf(fp_in, "%d", &x0);
  fscanf(fp_in, "%d", &x1);
  fscanf(fp_in, "%d", &x2);

  do
  {
    myfilter1(x0,x1,x2,&y0,&y1,&y2);
    fprintf(fp_out1, "%d\n", y0);
    fprintf(fp_out1, "%d\n", y1);
    fprintf(fp_out1, "%d\n", y2);

    myfilter2(x0, x1, x2, &y0, &y1, &y2);
    fprintf(fp_out2, "%d\n", y0);
    fprintf(fp_out2, "%d\n", y1);
    fprintf(fp_out2, "%d\n", y2);

    myfilter3(x0, x1, x2, &y0, &y1, &y2);
    fprintf(fp_out3, "%d\n", y0);
    fprintf(fp_out3, "%d\n", y1);
    fprintf(fp_out3, "%d\n", y2);

    fscanf(fp_in, "%d", &x0);
    fscanf(fp_in, "%d", &x1);
    fscanf(fp_in, "%d", &x2);
  } 
  while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out1);
  fclose(fp_out2);
  fclose(fp_out3);

  return 0;
}
