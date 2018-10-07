/**
 * 
 */
    // email checker
    function email_check( email ) {
        
        var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return (email != '' && email != 'undefined' && regex.test(email));
     
    }
    
    // password checker
    function password_check( password ) {
    	
        var regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{2,}$/;
        return (password != '' && email != 'undefined' && regex.test(password));
     
    }
    
    // success style maker
    function inputSuccess( targetForm, symbol, symbolStatus ) {
    	
		$(targetForm).attr({"class" : "form-group has-success has-feedback"});
		$(symbol).attr({"class" : "glyphicon glyphicon-ok form-control-feedback",
									"aria-hidden" : "true"});
		$(symbolStatus).attr({"class" : "sr-only" });
		$(symbolStatus).text("(success)");
    }
    
    // error style maker
    function inputError( targetForm, symbol, symbolStatus ) {
    	
		$(targetForm).attr({"class" : "form-group has-error has-feedback"});
		$(symbol).attr({"class" : "glyphicon glyphicon-remove form-control-feedback",
									"aria-hidden" : "true"});
		$(symbolStatus).attr({"class" : "sr-only" });
		$(symbolStatus).text("(error)");
    }
    
    	$(function(){
    		//1. email check( "@", "." )
    		$("#inputEmail").blur(function(){
    			//1.1 if (input email is satisfied regExp)
    			//var email = $("#inputEmail");
    			
    				//1.1.1 입력한 이메일이 조건을 만족할 때
    			if( email_check($("#inputEmail").val()) ){
    				inputSuccess("#email", "#emailCheckSymbol", "#emailCheckSymbolStatus");
    				//1.1.2 입력한 이메일이 조건을 만족하지 못할 때	
    			}else{
    				inputError("#email", "#emailCheckSymbol", "#emailCheckSymbolStatus");
    			}
    		});
    		
    		//2. email check check
    		$("#inputEmailCheck").blur(function(){
    			//2.1 emailcheck에 값이 ""이 아니고,
    			if($("#inputEmail").val() != ""){
    				//2.1.1 emailcheck의 값과 일치하면,
    				if($("#inputEmail").val() == $("#inputEmailCheck").val()){
    					inputSuccess("#emailCheck","#emailCheckCheckSymbol", "#emailCheckCheckSymbolStatus");
    				//2.1.2 emailcheck의 값과 일치하지 않으면,
    				}else{
    					inputError("#emailCheck","#emailCheckCheckSymbol", "#emailCheckCheckSymbolStatus");
    				}
    			} 
    		});
    		
       		//3. password check(  )
    		$("#inputPassword").blur(function(){
   			//1.1 if (input password is satisfied regExp)
   				//1.1.1 입력한 암호가 조건을 만족할 때
    			if( password_check($("#inputPassword").val()) ){
    				inputSuccess("#password", "#passwordCheckSymbol", "#passwordCheckSymbolStatus");
   				//1.1.2 입력한 이메일이 조건을 만족하지 못할 때	
    			}else{
    				inputError("#password", "#passwordCheckSymbol", "#passwordCheckSymbolStatus");
    			}
    		});
    		
       		//4. password check check(  )
    		$("#inputPasswordCheck").blur(function(){
    			//2.1 password check에 값이 ""이 아니고,
    			if($("#inputPassword").val() != ""){
    				//2.1.1 emailcheck의 값과 일치하면,
    				if($("#inputPassword").val() == $("#inputPasswordCheck").val()){
    					inputSuccess("#passwordCheck","#passwordCheckCheckSymbol", "#passwordCheckCheckSymbolStatus");
    				//2.1.2 emailcheck의 값과 일치하지 않으면,
    				}else{
    					inputError("#passwordCheck","#passwordCheckCheckSymbol", "#passwordCheckCheckSymbolStatus");
    				}
    			} 
    		});
    	});
