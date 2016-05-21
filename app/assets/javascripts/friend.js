
$(function(){
	$('#emailerr').addClass('hidden');
	$('#usererr').addClass('hidden');
	console.log('hiiiiiii');
	draw_table();
	//display all data in table in div in browser
	function draw_table() {
		$.ajax({
			url: '/friends',
			type: 'GET',
			dataType: 'json',
			success:function(response)
			{
				console.log(response)
				alldata=response
				HTMltext = '<table cellspacing=2 cellpadding=2 border=2>';
		 		HTMltext += '<tr>';
		 		HTMltext += '<th> ID </th>';
		 		HTMltext += '<th> fid </th>';
		 		HTMltext += '<th> Email </th>';
		 		HTMltext += '<th> gid</th>';
		 		HTMltext += '<th> usri</th>';
		 		HTMltext += '<th> REMOVE</th>';
		 		HTMltext += '</tr>';
				for (user in alldata)
					{
						HTMltext +='<tr>';
						HTMltext += '<td>'+alldata[user].id+'</td>';
						HTMltext += '<td>'+alldata[user].friend_id+'</td>';
						HTMltext += '<td>'+alldata[user].email+'</td>';
						HTMltext += '<td>'+alldata[user].group_id+'</td>';
						HTMltext += '<td>'+alldata[user].user_id+'</td>';
						HTMltext += '<td><a id="del" >Remove</a></td>';
						HTMltext += '</tr>';
					}
				HTMltext += '</table>';
				$('#alldata').html(HTMltext);
			},
			error:function() {
				console.log('error: NO there responser');
			}
		
		});		
	}

	// $('#email').on('blur', function(event) {
	// 	var Email = $('#email').val();
	// 	$.ajax({
	// 		// url:'/friends/checkmail/'+email
	// 		url:'/users'
	// 		// type: 'POST',
	// 		type: 'GET',
	// 		dataType: 'html',
	// 		success: function (response) 
	// 		{	console.log (ok);
	// 			// var data =response;
	// 			// var key = data.answer;
	// 			// if (key == 'true')
	// 			// {
	// 			// 	$('#emailerr').removeClass('hidden');
	// 			// 	$('#emailerr').html("your Email is exsist ");
	// 			// 	$('#email').select();
	// 			// 	// $('#email').focus();
	// 			// }
	// 			// else
	// 			// {
	// 			// 	$('#emailerr').removeClass('hidden');
	// 			// 	$('#emailerr').html("Sorry invalid Email");
	// 			// }
	// 		},
	// 		error:function() {
	// 			console.log('error: NO responser email');
	// 		}

	// 	});//end of ajax in check email	
	// });//end of on blur of email




	
});//end of on  load function