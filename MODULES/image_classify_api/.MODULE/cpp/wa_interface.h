
#ifndef __IMAGE_CLASSIFY_API_H_
#define __IMAGE_CLASSIFY_API_H_


#include "plc-base/.MODULE/cpp/runtime_interface.h"


#ifdef __cplusplus
#include "plc-base/.MODULE/cpp/wa_fb_base.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif

int CLASSIFY(int img_handle, int model_id);


/************* Function Block CAMERA *************/
#ifdef __cplusplus
extern "C" {
void __init_CAMERA(FBData *self);
}

class CAMERA : public IECFBBase {
    enum {
      LOC_img_chn,  // VAR_INPUT, int
      LOC_image,  // VAR_OUTPUT, int
    };

  private:
    CAMERA(const CAMERA &);
    CAMERA &operator=(const CAMERA &);

  private:
    int img_chn;
    int image;

  public:
    CAMERA();
    virtual ~CAMERA();
    virtual void call() override;

    const static int IEC_FIELD_CNT = 2;
};
#endif /* end of __cplusplus */
/*********** End Function Block CAMERA ***********/

#ifdef __cplusplus
}
#endif

#endif /* end of __IMAGE_CLASSIFY_API_H_ */

