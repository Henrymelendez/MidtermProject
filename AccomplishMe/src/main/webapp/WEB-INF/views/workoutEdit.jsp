<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Create New Workout</title>
	<link rel="stylesheet" type="text/css" href="css/multi-form.css?v2">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/multi-form.js?v2"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$.validator.addMethod('met', function(value, element, param) {
				return (value  > 0) && (value <= 40) && (value == parseFloat(value, 10));
			}, 'Please enter a MET Value');
			$.validator.addMethod('name', function(value, element, param) {
				var nameRegex = /^[a-zA-Z0-9]+$/;
				return value.match(nameRegex);
			}, 'Only a-z, A-Z, 0-9 characters are allowed');

			var val	=	{
			    // Specify validation rules
			    rules: {
			    	name: "required",
			    	description:  "required",
					met:{
						met:true,
						required:true,
						minlength:1,
						maxlength:3,
						digits:true
					}
			    },
			    // Specify validation error messages
			    messages: {
			    	name: 			"Name is required",
			    	description: 	"Description is required",
				
					met:{
						required: 	"MET required",
						minlength: 	"Should be at least 1 ",
						maxlength: 	"Should be below 20",
						digits: 	"MET Value should be a number"
			    }
			}
			}
			$("#myForm").multiStepForm(
			{
				// defaultStep:0,
				beforeSubmit : function(form, submit){
					console.log("called before submiting the form");
					console.log(form);
					console.log(submit);
				},
				validations:val,
			}
			).navigateTo(0);
		});
	</script>
</head>
<body>
	<h1 style="margin-top:50px; color: #141206;">Add New Workout</h1>
	<form id="myForm" action="editDetail.cdc" method="POST">
	  <h1>Workout Form</h1>
	  <!-- One "tab" for each step in the form: -->
	  <div class="tab">Workout Info:
	    <p><input value="${detail.name }" name="name"></p>
	    <p><input value="${detail.description }" name="description"></p>
	    <p><input value="${detail.met }" name="met"></p>
	    <input hidden="true" name="id" value="${detail.id }">
	  </div>
	    <!-- <div class="tab">
	    </div> -->
	  <div style="overflow:auto;">
	    <div style="float:right; margin-top: 5px;">
	    <button type="button" class="previous">Previous</button>
			<button type="button" class="submit">Submit</button>
	    </div>
	  </div>
	  <a href="userTasks.user"><button  type="button" class="cancel">Cancel</button></a>
	  <!-- Circles which indicates the steps of the form: -->
	  <div style="text-align:center;margin-top:40px;">
	    <span class="step">1</span>
	   <!--  <span class="step">2</span> -->
	    
	  </div>
	</form>
</body>
</html>