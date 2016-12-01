

function multi_email(subject) {
    var  email_list = []
    console.log(subject)
    $("input:checkbox[name=request_ids\\[\\]][sub=" + subject +"]:checked").each(function(){
        email_list.push($(this).data("mail"));
    });
    
    var uniq_email_list = email_list.filter(function(itm, i) {
        return email_list.indexOf(itm)== i; 
    });
    
    uniq_email_list.join(',');
    if (uniq_email_list.length >= 1)
        window.open("mailto:" + uniq_email_list + "?subject=" + "Force Request System: Regarding course " + subject);
}