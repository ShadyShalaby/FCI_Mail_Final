function isEmail(email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
}

function validateSignUpForm()
{
    var email = document.getElementById("inputUserEmail").value;

    if (!isEmail(email))
    {
        alert("Not a valid e-mail address format.");
        return false;
    }
    return true;
}


                       