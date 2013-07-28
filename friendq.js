// Read a page's GET URL variables and return them as an associative array.
function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}


function loadDetails(){
	$("#num").html(getUrlVars()["item"]);
	
}

function refreshPage()
{
    jQuery.mobile.changePage(window.location.href, {
        allowSamePageTransition: false,
        transition: 'none',
        reloadPage: true
    });
}
function rated(ids,rs){
	r = parseInt(rs);
	id = parseInt(ids);
	
	console.log( "setting rating to " + r ); 
	
	$.get("api/rate.php?id="+id+"&rating="+r);
	
	if(r > 0){
		$("#currentrating_"+id).text( "You liked it.");
		
	} else if (r < 0){
		$("#currentrating_"+id).text( "You didn't like it.");
		//alert("no like");
	} else {
		$("#currentrating_"+id).text( "You haven't rated this yet.");
	}
	

}