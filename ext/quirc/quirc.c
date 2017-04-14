#include <ruby.h>
#include <quirc.h>

static VALUE mQuirc, cDecoder, cResult;

static void decoder_free(struct quirc *qr) {
    quirc_destroy(qr);
}

static VALUE decoder_alloc(VALUE self) {
    struct quirc *qr = quirc_new();
    if (qr == NULL) {
        rb_raise(rb_const_get(rb_cObject, rb_intern("NoMemoryError")), "Could not allocate memory");
    }
    return Data_Wrap_Struct(self, NULL, decoder_free, qr);
}

static VALUE decoder_m_initialize(VALUE self, VALUE width, VALUE height) {
    struct quirc *qr;

    Data_Get_Struct(self, struct quirc, qr);
    if (quirc_resize(qr, NUM2INT(width), NUM2INT(height)) < 0) {
        rb_raise(rb_const_get(rb_cObject, rb_intern("NoMemoryError")), "Could not allocate memory");
    }
    rb_iv_set(self, "@width", width);
    rb_iv_set(self, "@height", height);

    return Qnil;
}

static VALUE decoder_m_decode(VALUE self, VALUE image) {
    struct quirc *qr;
    int width, height, size;
    uint8_t *buffer;
    int num_codes;
    VALUE results;

    Check_Type(image, T_STRING);
    Data_Get_Struct(self, struct quirc, qr);

    buffer = quirc_begin(qr, &width, &height);
    size = width * height;
    if (RSTRING_LEN(image) != size) {
        rb_raise(rb_const_get(rb_cObject, rb_intern("ArgumentError")), "Decoder is allocated for %dx%d images", width, height);
    }
    memcpy(buffer, StringValuePtr(image), size);
    quirc_end(qr);

    num_codes = quirc_count(qr);
    results = rb_ary_new2(num_codes);
    for (int i = 0; i < num_codes; i++) {
        struct quirc_code code;
        struct quirc_data data;
        quirc_decode_error_t err;
        VALUE item;

        quirc_extract(qr, i, &code);
        err = quirc_decode(&code, &data);
        if (err) continue;

        item = rb_class_new_instance(0, NULL, cResult);
        rb_iv_set(item, "@version", INT2FIX(data.version));
        rb_iv_set(item, "@ecc_level", INT2FIX(data.ecc_level));
        rb_iv_set(item, "@mask", INT2FIX(data.mask));
        rb_iv_set(item, "@data_type", INT2FIX(data.data_type));
        rb_iv_set(item, "@payload", rb_str_freeze(rb_str_new((const char *) data.payload, data.payload_len)));
        rb_iv_set(item, "@eci", INT2NUM(data.eci));
        rb_ary_push(results, item);
    }

    return results;
}

void Init_quirc(void) {
    mQuirc = rb_const_get(rb_cObject, rb_intern("Quirc"));
    rb_define_const(mQuirc, "LIB_VERSION", rb_str_freeze(rb_str_new_cstr(quirc_version())));

    cDecoder = rb_define_class_under(mQuirc, "Decoder", rb_cObject);
    rb_define_alloc_func(cDecoder, decoder_alloc);
    rb_define_method(cDecoder, "initialize", decoder_m_initialize, 2);
    rb_define_method(cDecoder, "decode", decoder_m_decode, 1);
    rb_define_attr(cDecoder, "width", 1, 0);
    rb_define_attr(cDecoder, "height", 1, 0);

    cResult = rb_define_class_under(mQuirc, "Result", rb_cObject);
    rb_define_attr(cResult, "version", 1, 0);
    rb_define_attr(cResult, "ecc_level", 1, 0);
    rb_define_attr(cResult, "mask", 1, 0);
    rb_define_attr(cResult, "data_type", 1, 0);
    rb_define_attr(cResult, "payload", 1, 0);
    rb_define_attr(cResult, "eci", 1, 0);
}
