
function Validation(){ 
    let email= $('#email').val();
    let password= $('#password').val();
    if(email=='')
    {
        $('#email').attr('placeholder','Email required');
        $('#email').css('border-color','#F00');
        return false;
    }
    else if(password=='')
    {
        $('#password').attr('placeholder','Password required');
        $('#password').css('border-color','#F00');
        return false;
    }
    else{
        return true;
    }                                       
}
function ValidationSignup(){ 

    let name= $('#name').val();
    let age   = $('#age').val();
    let gender= $('#gender').val();
    let email   = $('#email').val();
    let phone= $('#phone').val();
    let userName= $('#userName').val();
    let password= $('#password').val();
    let cpassword= $('#cpassword').val();
    if(name=='')
    {
        alert('Name required');
        $('#name').val("");
        $('#name').css('border-color','#F00');
        return false;
    }  
    if(age=='')
    {
        alert('Age required');
        $('#age').val("");
        $('#age').css('border-color','#F00');
        return false;
    }
    if(gender=='')
    {
        alert("Select your gender");
        return false;
    }
    //let phoneNum = phone.replace(/[^\d]/g, '');
    if(phone=='')
    {
        alert(' Phone required');
        $('#phone').val("");
        $('#phone').css('border-color','#F00');
        return false;
    } 
    var filter = /^\d*(?:\.\d{1,2})?$/;
    if(filter.test(phone)) {
        if(phone.length < 6 && phone.length < 11) {  
            alert(' Enter a valid Phone number length');
            $('#phone').val("");
            $('#phone').css('border-color','#F00');
            return false;  
        }
    }
    else{
        alert(' Enter a valid Phone number');
        $('#phone').val("");
        $('#phone').css('border-color','#F00');
        return false;  
    }
    
    
    if(email=='')
    {
        alert('Email required');
        $('#email').val("");
        $('#email').css('border-color','#F00');
        return false;
    }  
    if(userName=='')
    {
        alert(' Username required');
        $('#userName').val("");
        $('#userName').css('border-color','#F00');
        return false;
    }
    else if(password=='')
    {
        alert('Password required');
        $('#password').val("");
        $('#password').css('border-color','#F00');
        return false;
    }
    else if(cpassword!=password)
    {
        alert('password and confirm password must be equal');
        $('#cpassword').val("");
        $('#cpassword').css('border-color','#F00');
        return false;
    }
    else{
        return true;
    }                                       
}		
		
function printDiv(divName) {
    var printContents = document.getElementById(divName).innerHTML;
    var originalContents = document.body.innerHTML;
   
    document.body.innerHTML = printContents;
   
    window.print();
   
    document.body.innerHTML = originalContents;
}
setTimeout(function() {
    $('#message').fadeOut('fast');
}, 3000); // <-- time in milliseconds
