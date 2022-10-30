(*
    class name and index mapping
    pineapple, ananas: 953;
    banana: 954;
*)

TYPE
    CATEGORY : (Unknown, Banana, Pineapple, Orange) := Unknown;
END_TYPE



PROGRAM image_classify
    VAR
        Reg_6041_status AT %IW1000 : INT;
        Reg_6064_actual_pos AT %ID1002 : DINT;

        Reg_6040_control_word AT %QW1000 : INT;
        Reg_607a_target_pos AT %QD1002 : DINT;
        Reg_6060_modesel AT %QB1006 : SINT;
        Reg_60ff_target_vel AT %QD1008 : DINT;

        cnt : INT := 0;

        Last_6041_status : INT := -1;
        Last_6040_control_word : INT := -1;
    END_VAR

    VAR
        trigger AT %IX0 : BOOL;
        classify_output : DINT;
        img : DINT;
        prev : BOOL;
        cam : CAMERA;
        last_classify_output : CATEGORY := CATEGORY#Unknown;
        res : CATEGORY;
        name : STRING;
    END_VAR

    VAR_OUTPUT
        //res2 AT %QD10 : DINT;
    END_VAR

    IF Last_6041_status <> Reg_6041_status THEN
         WA_LOG('Reg_6041_status changed from %d (0X%X) to %d (0X%X),  act-pos=%d (0X%X), servo_status=0X%X', 
            Last_6041_status, Last_6041_status, Reg_6041_status, Reg_6041_status, Reg_6064_actual_pos, Reg_6064_actual_pos, servo_status);
            Last_6041_status := Reg_6041_status;
       
    END_IF;
     
    Reg_60ff_target_vel := 0;
    Reg_6040_control_word := 0;
    Reg_60ff_target_vel := 16#1000000 ;
    name := 'unknown';

    IF Reg_6041_status = 16#218 THEN
        Reg_6040_control_word := 16#0080;

    ELSIF (Reg_6041_status AND INT#16#004F) = INT#16#0040  THEN
        Reg_6040_control_word := 16#0006;

    ELSIF (Reg_6041_status AND 16#006F) = 16#0021  THEN
        Reg_6040_control_word := 16#0007;

    ELSIF (Reg_6041_status AND 16#006F) = 16#0023  THEN
        Reg_6060_modesel := 9;
        Reg_6040_control_word := 16#000F;

    ELSIF (Reg_6041_status AND 16#006F) = 16#0027  THEN
        Reg_60ff_target_vel := 16#1000000 ;
        Reg_6040_control_word := 16#001F;
    END_IF;
    

    IF Last_6040_control_word <>  Reg_6040_control_word THEN
    WA_LOG('Reg_6040_control_word changed from %d (0X%X) to %d (0X%X)', 
        Last_6040_control_word, Last_6040_control_word, Reg_6040_control_word, Reg_6040_control_word);
    WA_LOG('Reg_6060_modesel = %d (0X%X)', Reg_6060_modesel, Reg_6060_modesel);
    WA_LOG('Reg_60ff_target_vel = %d (0X%X) $n', Reg_60ff_target_vel, Reg_60ff_target_vel);

    Last_6040_control_word := Reg_6040_control_word;
        
    END_IF;

    g_do0 := g_do0 +1;
     

    cam(img_chn := 0);
    img := cam.image;
    classify_output := CLASSIFY(img_handle := img, model_id := 0);

    IF classify_output = 953 THEN
        res := CATEGORY#Pineapple;
        name := 'Pineapple';
    ELSIF classify_output = 954 THEN
        res := CATEGORY#Banana;
        g_do1 := 1;
        Reg_60ff_target_vel := 16#1000000 ;
        name := 'Banana';
    ELSIF classify_output = 950 THEN
        res := CATEGORY#Orange;
        g_do1 := 128;
        Reg_60ff_target_vel := 16#4000000 ;
        name := 'Orange';
    ELSE
        res := CATEGORY#Unknown;
        g_do1 := 255;
        Reg_60ff_target_vel := 16#100000;
        name := 'Unknown';
    END_IF;

   IF last_classify_output <> res THEN
       WA_LOG('The classification result is: [%s]', name);
   END_IF;
   

    last_classify_output := res;


    prev := trigger;

END_PROGRAM
