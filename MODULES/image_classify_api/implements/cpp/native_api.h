
#ifndef __NATIVE_API_H_
#define __NATIVE_API_H_

#ifdef __cplusplus
extern "C" {
#endif

__attribute__((import_module("openvino")))
__attribute__((import_name("plc_image_classify")))
int
plc_image_classify(int image_handle, int model_id);

__attribute__((import_module("openvino")))
__attribute__((import_name("plc_take_photo")))
int
plc_take_photo(int image_channel);

#ifdef __cplusplus
}
#endif

#endif /* end of __NATIVE_API_H_ */
