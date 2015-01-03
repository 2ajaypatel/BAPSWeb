function OnlyNumeric(evt, ctrl) {

        if (evt.keyCode >= 48 && evt.keyCode <= 57) //Numbers
            return true;
        else if (evt.keyCode >= 96 && evt.keyCode <= 105)//Numeric Keypad
            return true;
        else if (evt.keyCode == 9)//tab key
            return true;
        else
            return false;
   

} 

function validateAlphabet() {
    if (!(event.keyCode >= 65 && event.keyCode <= 90) && !(event.keyCode >= 97 && event.keyCode <= 122)) {
        event.returnValue = false;
    }
}