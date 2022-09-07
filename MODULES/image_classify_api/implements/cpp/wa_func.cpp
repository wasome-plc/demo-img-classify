#include "../../.MODULE/cpp/wa_interface.h"
#include "native_api.h"

int CLASSIFY(int img_handle, int model_id) {
    return plc_image_classify(img_handle, model_id);
}
