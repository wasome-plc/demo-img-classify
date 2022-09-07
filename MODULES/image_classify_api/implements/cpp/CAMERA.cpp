#include "../../.MODULE/cpp/wa_interface.h"
#include "native_api.h"

/************* Function Block CAMERA *************/
/* USER INCLUDE START */

/* USER INCLUDE END */

/* USER DECLARATION START */

/* USER DECLARATION END */

void __init_CAMERA(FBData *self) { self->fb_self = new CAMERA(); }

const int CAMERA::IEC_FIELD_CNT;

CAMERA::CAMERA() {
    value_map_len = CAMERA::IEC_FIELD_CNT;

    value_addr_map_ =
        (void **)malloc(CAMERA::IEC_FIELD_CNT * sizeof(void *));
    value_addr_map_[LOC_img_chn] = &img_chn;
    value_addr_map_[LOC_image] = &image;

    value_bytes_map_ =
        (unsigned char *)malloc(CAMERA::IEC_FIELD_CNT);
    value_bytes_map_[LOC_img_chn] = sizeof(int);
    value_bytes_map_[LOC_image] = sizeof(int);

    /* USER CONSTRUCT START */

    /* USER CONSTRUCT END */
}

CAMERA::~CAMERA() {
    /* USER DESTRUCT START */

    /* USER DESTRUCT END */
}

void CAMERA::call() {
    /* USER CALL START */
    image = plc_take_photo(img_chn);
    /* USER CALL END */
}

/* USER CODE START */

/* USER CODE END */
/*********** End Function Block CAMERA ***********/
