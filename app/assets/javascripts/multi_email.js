

function multi_email(subject, email_list) {
    
    email_list = []
    console.log(subject)
    $("input:checkbox[name=request_ids][id=" + subject +"]:checked").each(function(){
        email_list.push($(this).val());
    });
    
    console.log(email_list)
    alert(email_list)
    var uniq_email_list = email_list.filter(function(itm, i) {
        return email_list.indexOf(itm)== i; 
    });
    uniq_email_list.join(',');
    if (uniq_email_list.length >= 1)
        window.open("mailto:" + uniq_email_list + "?subject=" + "Force Request System: Regarding course " + subject);
}