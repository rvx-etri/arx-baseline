/* ----------------------------------------------------------------- */
/*             The Speech Signal Processing Toolkit (SPTK)           */
/*             developed by SPTK Working Group                       */
/*             http://sp-tk.sourceforge.net/                         */
/* ----------------------------------------------------------------- */
/*                                                                   */
/*  Copyright (c) 1984-2007  Tokyo Institute of Technology           */
/*                           Interdisciplinary Graduate School of    */
/*                           Science and Engineering                 */
/*                                                                   */
/*                1996-2016  Nagoya Institute of Technology          */
/*                           Department of Computer Science          */
/*                                                                   */
/* All rights reserved.                                              */
/*                                                                   */
/* Redistribution and use in source and binary forms, with or        */
/* without modification, are permitted provided that the following   */
/* conditions are met:                                               */
/*                                                                   */
/* - Redistributions of source code must retain the above copyright  */
/*   notice, this list of conditions and the following disclaimer.   */
/* - Redistributions in binary form must reproduce the above         */
/*   copyright notice, this list of conditions and the following     */
/*   disclaimer in the documentation and/or other materials provided */
/*   with the distribution.                                          */
/* - Neither the name of the SPTK working group nor the names of its */
/*   contributors may be used to endorse or promote products derived */
/*   from this software without specific prior written permission.   */
/*                                                                   */
/* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND            */
/* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,       */
/* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF          */
/* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE          */
/* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS */
/* BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,          */
/* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED   */
/* TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,     */
/* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON */
/* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   */
/* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    */
/* OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE           */
/* POSSIBILITY OF SUCH DAMAGE.                                       */
/* ----------------------------------------------------------------- */

/***********************************************************
   $Id: SPTK.h,v 1.66 2016/12/25 05:00:20 uratec Exp $

   Speech Signal Processing Toolkit
   SPTK.h
***********************************************************/

#ifndef SPTK_H_
#define SPTK_H_

#include <stddef.h>
#include "ervp_fakefile.h"

#ifndef DLLEXPORT
#  ifdef _MSC_VER
#      define DLLEXPORT __declspec(dllexport)
#    else
#      define DLLEXPORT
#  endif
#endif

#ifndef PI
#define PI  3.14159265358979323846
#endif                          /* PI */

#ifndef PI2
#define PI2 6.28318530717958647692
#endif                          /* PI2 */

#ifndef M_PI
#define M_PI  3.1415926535897932384626433832795
#endif                          /* M_PI */

#ifndef M_2PI
#define M_2PI 6.2831853071795864769252867665590
#endif                          /* M_2PI */

#define LN_TO_LOG 4.3429448190325182765

#define LZERO (-1.0e+10)
#define LSMALL (-0.5e+10)

/* #ifndef ABS(x) */
#define ABS(x) ((x<0.0) ? -x : x)
/* #endif */

#ifdef __BIG_ENDIAN
#if __BYTE_ORDER == __BIG_ENDIAN
#define WORDS_BIGENDIAN
#endif
#endif

#if defined (__cplusplus)
extern "C" {
#endif

/* enum for Boolean */
typedef enum _Boolean { FA, TR } Boolean;

/* enum for window type */
typedef enum _Window {
   BLACKMAN,
   HAMMING,
   HANNING,
   BARTLETT,
   TRAPEZOID,
   RECTANGULAR
} Window;

/* struct for Complex */
typedef struct {
   double re;
   double im;
} Complex;

/* struct for Gaussian distribution */
typedef struct _Gauss {
   double *mean;
   double *var;
   double **cov;
   double **inv;
   double gconst;
} Gauss;

/* structure for GMM */
typedef struct _GMM {
   int nmix;
   int dim;
   Boolean full;
   double *weight;
   Gauss *gauss;
} GMM;

typedef struct _deltawindow {
   size_t win_size;
   size_t win_max_width;
   int *win_l_width;
   int *win_r_width;
   double **win_coefficient;
} DELTAWINDOW;

/* structure for wavsplit and wavjoin */
typedef struct _wavfile {
   int file_size;               /* file size */
   int fmt_chunk_size;          /* size of 'fmt ' chunk (byte) */
   int data_chunk_size;         /* size of 'data' chunk (byte) */
   short format_id;             /* format ID (PCM(1) or IEEE float(3)) */
   short channel_num;           /* mono:1: stereo:2 */
   int sample_freq;             /* sampling frequency (Hz) */
   int byte_per_sec;            /* byte per second */
   short block_size;            /* 16bit, mono => 16bit*1=2byte */
   short bit_per_sample;        /* bit per sample */
   short extended_size;         /* size of 'extension' */

   char input_data_type;
   char format_type;

   char *data;                  /* waveform data */

} Wavfile;

typedef struct _filelist {
   int num;
   char **name;
} Filelist;

/* library routines */
double agexp(double r, double x, double y);
int cholesky(double *c, double *a, double *b, const int n, double eps);
int freada(double *p, const int bl, FAKEFILE * fp);
int fwritex(void *ptr, const size_t size, const int nitems, FAKEFILE * fp);
int freadx(void *ptr, const size_t size, const int nitems, FAKEFILE * fp);
int fwritef(double *ptr, const size_t size, const int nitems, FAKEFILE * fp);
int freadf(double *ptr, const size_t size, const int nitems, FAKEFILE * fp);
int fwrite_little_endian(void *ptr, const size_t size,
                         const size_t n, FAKEFILE * fp);
void fillz(void *ptr, const size_t size, const int nitem);
FAKEFILE *getfp(char *name, char *opt);
short *sgetmem(const int leng);
long *lgetmem(const int leng);
double *dgetmem(const int leng);
float *fgetmem(const int leng);
/* real *rgetmem (const int leng); */
float **ffgetmem(const int leng);
double **ddgetmem(const int leng1, const int leng2);
char *getmem(const size_t leng, const size_t size);
double gexp(const double r, const double x);
double glog(const double r, const double x);
int ifftr(double *x, double *y, const int l);
double invert(double **mat, double **inv, const int n);
void multim(double x[], const int xx, const int xy, double y[], const int yx,
            const int yy, double a[]);
void addm(double x[], double y[], const int xx, const int yy, double a[]);
void movem(void *a, void *b, const size_t size, const int nitem);
int mseq(void);
int theq(double *t, double *h, double *a, double *b, const int n, double eps);
int toeplitz(double *t, double *a, double *b, const int n, double eps);


/* tool routines */
double acep(double x, double *c, const int m, const double lambda,
            const double step, const double tau, const int pd,
            const double eps);
void acorr(double *x, int l, double *r, const int np);
double agcep(double x, double *c, const int m, const int stage,
             const double lambda, const double step, const double tau,
             const double eps);
double amcep(double x, double *b, const int m, const double a,
             const double lambda, const double step, const double tau,
             const int pd, const double eps);
void phidf(const double x, const int m, double a, double *d);
void b2mc(double *b, double *mc, int m, const double a);
void c2acr(double *c, const int m1, double *r, const int m2, const int flng);
void c2ir(double *c, const int nc, double *h, const int leng);
void c2ndps(double *c, const int m, double *n, const int l);
void ic2ir(double *h, const int leng, double *c, const int nc);
void c2sp(double *c, const int m, double *x, double *y, const int l);
void clip(double *x, const int l, const double min, const double max,
          double *y);
int dft(float *pReal, float *pImag, const int nDFTLength);
void dct(float *in, float *out, const int size, const int m,
         const int dftmode, const int compmode);
int dct_create_table_fft(const int nSize);
int dct_create_table(const int nSize);
int dct_based_on_fft(float *pReal, float *pImag, const float *pInReal,
                     const float *pInImag);
int dct_based_on_dft(float *pReal, float *pImag, const float *pInReal,
                     const float *pInImag);
double df2(const double x, const double sf, const double f0p, const double wbp,
           const double f0z, const double wbz, const int fp, const int fz,
           double *buf, int *bufp);
double dfs(double x, double *a, int m, double *b, int n, double *buf,
           int *bufp);
int fft(float *x, float *y, const int m);
int fft2(double x[], double y[], const int n);
void fftcep(double *sp, const int flng, double *c, const int m, int itr,
            double ac);
int fftr(float *x, float *y, const int m);
int fftr2(double x[], double y[], const int n);
void freqt(double *c1, const int m1, double *c2, const int m2, const double a);
void gc2gc(double *c1, const int m1, const double g1, double *c2, const int m2,
           const double g2);
int gcep(double *xw, const int flng, double *gc, const int m, const double g,
         const int itr1, const int itr2, const double d, const int etype,
         const double e, const double f, const int itype);
double glsadf(double x, double *c, const int m, const int n, double *d);
double glsadf1(double x, double *c, const int m, const int n, double *d);
double glsadft(double x, double *c, const int m, const int n, double *d);
double glsadf1t(double x, double *c, const int m, const int n, double *d);
double cal_gconst(double *var, const int D);
double cal_gconstf(double **var, const int D);
double log_wgd(const GMM * gmm, const int m, const int L1, const int L2,
               const double *dat);
double log_add(double logx, double logy);
double log_outp(const GMM * gmm, const int L1, const int L2, const double *dat);
void fillz_GMM(GMM * gmm);
int alloc_GMM(GMM * gmm, const int M, const int L, const Boolean full);
int load_GMM(GMM * gmm, FAKEFILE * fp);
int save_GMM(const GMM * gmm, FAKEFILE * fp);
int free_GMM(GMM * gmm);
int prepareCovInv_GMM(GMM * gmm);
int prepareGconst_GMM(GMM * gmm);
int floorWeight_GMM(GMM * gmm, double floor);
int floorVar_GMM(GMM * gmm, double floor);
void gnorm(double *c1, double *c2, int m, const double g);
void grpdelay(double *x, double *gd, const int size, const int is_arma);
int histogram(double *x, const int size, const double min, const double max,
              const double step, double *h);
int ifft(double *x, double *y, const int m);
int ifft2(double x[], double y[], const int n);
double iglsadf(double x, double *c, const int m, const int n, double *d);
double iglsadf1(double x, double *c, const int m, const int n, double *d);
double iglsadft(double x, double *c, const int m, const int n, double *d);
double iglsadf1t(double x, double *c, const int m, const int n, double *d);
void ignorm(double *c1, double *c2, int m, const double g);
double imglsadf(double x, double *b, const int m, const double a, const int n,
                double *d);
double imglsadf1(double x, double *b, const int m, const double a, const int n,
                 double *d);
double imglsadft(double x, double *b, const int m, const double a, const int n,
                 double *d);
double imglsadf1t(double x, double *b, const int m, const double a, const int n,
                  double *d);
void imsvq(int *index, double *cb, const int l, int *cbsize, const int stage,
           double *x);
void ivq(const int index, double *cb, const int l, double *x);
void lbg(double *x, const int l, const int tnum, double *icb, int icbsize,
         double *cb, const int ecbsize, const int iter, const int mintnum,
         const int seed, const int centup, const double delta,
         const double end);
int levdur(double *r, double *a, const int m, double eps);
double lmadf(double x, double *c, const int m, const int pd, double *d);
double cascade_lmadf(double x, double *c, const int m, const int pd, double *d,
                     const int block_num, int *block_size);
double lmadft(double x, double *c, const int m, const int pd, double *d,
              const int block_num, int *block_size);
double lmadf1(double x, double *c, const int m, double *d, const int pd,
              const int m1, const int m2);
double lmadf2t(double x, double *b, const int m, const int pd, double *d,
               const int m1, const int m2);
int lpc(double *x, const int flng, double *a, const int m, const double f);
void lpc2c(double *a, int m1, double *c, const int m2);
int lpc2lsp(double *lpc, double *lsp, const int order, const int numsp,
            const int maxitr, const double eps);
int lpc2par(double *a, double *k, const int m);
void lsp2lpc(double *lsp, double *a, const int m);
void lsp2sp(double *lsp, const int m, double *x, const int l, const int gain);
int lspcheck(double *lsp, const int ord);
double lspdf_even(double x, double *f, const int m, double *d);
double lspdf_odd(double x, double *f, const int m, double *d);
double ltcdf(double x, double *k, int m, double *d);
void mc2b(double *mc, double *b, int m, const double a);
int mcep(double *xw, const int flng, double *mc, const int m, const double a,
         const int itr1, const int itr2, const double dd, const int etype,
         const double e, const double f, const int itype);
float init_window(int type, const int size, const int nflg);
void init_mel_filter_banks(float fs, const int leng, const int n);
void mfcc(float *in, float *mc, const float sampleFreq, const float alpha,
          const float eps, const int wlng, const int flng, const int m,
          const int n, const int ceplift, const int dftmode,
          const int usehamming);
void get_mfcc(float *in, int in_len, float *mfccs, const float fs,
		const int wsize, const int wstride, const int fftsize,
		const int dcc, const int nmfb);
void log_mel_spectrum(float *in, float *out, const float sampleFreq,
		const float alpha, const float eps, const int wlng,
		const int flng, const int n, const int usehamming);
void get_log_mel_spectrum(float *in, int in_len, float *lms, const float fs,
      const int wsize, const int wstride, const int fftsize, const int nmfb);
void test_mfcc(int wlng, int flng, int m, int n);
void maskCov_GMM(GMM * gmm, const int *dim_list, const int cov_dim,
                 const Boolean block_full, const Boolean block_corr);
void frqtr(double *c1, int m1, double *c2, int m2, const double a);
void mgc2mgc(double *c1, const int m1, const double a1, const double g1,
             double *c2, const int m2, const double a2, const double g2);
void mgc2sp(double *mgc, const int m, const double a, const double g, double *x,
            double *y, const int flng);
void mgclsp2sp(double a, double g, double *lsp, const int m, double *x,
               const int l, const int gain);
int mgcep(double *xw, int flng, double *b, const int m, const double a,
          const double g, const int n, const int itr1, const int itr2,
          const double dd, const int etype, const double e, const double f,
          const int itype);
double newton(double *x, const int flng, double *c, const int m, const double a,
              const double g, const int n, const int j, const double f);
double mglsadf(double x, double *b, const int m, const double a, const int n,
               double *d);
double mglsadf1(double x, double *b, const int m, const double a, const int n,
                double *d);
double mglsadft(double x, double *b, const int m, const double a, const int n,
                double *d);
double mglsadf1t(double x, double *b, const int m, const double a, const int n,
                 double *d);
int str2darray(char *c, double **x);
int isfloat(char *c);
double mlsadf(double x, double *b, const int m, const double a, const int pd,
              double *d);
double mlsadft(double x, double *b, const int m, const double a, const int pd,
               double *d);
void msvq(double *x, double *cb, const int l, int *cbsize, const int stage,
          int *index);
void ndps2c(double *n, const int l, double *c, const int m);
void norm0(double *x, double *y, int m);
int nrand(double *p, const int leng, const int seed);
double nrandom(unsigned long *next);
unsigned long srnd(const unsigned int seed);
void par2lpc(double *k, double *a, const int m);
void phase(double *p, const int mp, double *z, const int mz, double *ph,
           const int flng, const int unlap);
double poledf(double x, double *a, int m, double *d);
double poledft(double x, double *a, int m, double *d);
void reverse(double *x, const int l);
double rmse(double *x, double *y, const int n);
void output_root_pol(Complex * x, int odr, int form);
void root_pol(double *a, const int odr, Complex * x, const int a_zero,
              const double eps, const int itrat);
Complex *cplx_getmem(const int leng);
int smcep(double *xw, const int flng, double *mc, const int m, const int fftsz,
          const double a, const double t, const int itr1, const int itr2,
          const double dd, const int etype, const double e, const double f,
          const int itype);
int uels(double *xw, const int flng, double *c, const int m, const int itr1,
         const int itr2, const double dd, const int etype, const double e,
         const int itype);
double ulaw_c(const double x, const double max, const double mu);
double ulaw_d(const double x, const double max, const double mu);
int vc(const GMM * gmm, const DELTAWINDOW * window, const size_t total_frame,
       const size_t source_vlen, const size_t target_vlen,
       const double *gv_mean, const double *gv_vari,
       const double *source, double *target);
int vq(double *x, double *cb, const int l, const int cbsize);
double edist(double *x, double *y, const int m);
float window(int type, float *x, const int size, const int nflg);
double zcross(double *x, const int fl, const int n);
double zerodf(double x, double *b, int m, double *d);
double zerodft(double x, double *b, const int m, double *d);
double zerodf1(double x, double *b, int m, double *d);
double zerodf1t(double x, double *b, const int m, double *d);

/* wavsplit and wavjoin */
void copy_wav_header(Wavfile * dest_wav, const Wavfile * source_wav);
void separate_path(char **dir, char **name, char *path);
Boolean get_wav_list(Filelist * filelist, const char *dirname);
Boolean wavread(Wavfile * wavfile, const char *fullpath);
Boolean wavwrite(Wavfile * wavfile, const char *outpath);
void wavsplit(Wavfile * wavout, const Wavfile * wavin);
void free_wav_list(Filelist * filelist);
void free_wav_data(Wavfile * wavfile);
void wavjoin(Wavfile * wavout, const Wavfile * wavin);
int search_wav_list(Filelist * filelist, char *key);

Wavfile *wavmake(int sample_freq, int channel_num,
    int depth, int data_num, void *data);
void print_wav(const Wavfile *wavfile);

/* excitation */
void excite(double *pitch, int n, double *out, int fprd, int iprd, Boolean gauss, int seed_i);

DLLEXPORT void swipe(double *input, double *output, int length, int samplerate, int frame_shift, double min, double max, double st, int otype);

/****************************************************************
    The RAPT pitch tracker

        return   value :    0 -> completed normally
                            1 -> invalid/inconsistent parameters
                            2 -> input range too small
                            3 -> problem in init_dp_f0

*****************************************************************/
int rapt(float *input, float* output, int length, double sample_freq,
     int frame_shift, double minF0, double maxF0, double voice_bias, int otype);

void b2c(double *b, int m1, double *c, int m2, double a);

#if defined (__cplusplus)
}
#endif

#endif  /* SPTK_H_ */
