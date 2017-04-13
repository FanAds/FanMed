function subscribe() {
    var email = document.getElementById('subscribeEmail').value;
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    document.getElementById("subscribeEmail").style.borderColor = "#ABB0B2";
    var pageId = document.head.querySelector("meta[property='fanads:page_id']").content

    if (emailPattern.test(email)) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText == 'OK') {
                    document.getElementById("subscribeContainer").innerHTML = 'Success';
                }
            }
        };
        xhttp.open("GET", "https://fbfanads.com/fanads-backend/blog_mailing_list/subscribe.php?email=" + email + "&page_id=" + pageId, true);
        xhttp.send();
    } else {
        document.getElementById("subscribeEmail").style.borderColor = "red";
    }
    return false;
}
