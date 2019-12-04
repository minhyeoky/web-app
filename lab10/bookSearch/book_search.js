// import './prototype.js'

// alert('book_search.js');
function ajaxFailure(ajax, exception) {
    alert("Error making Ajax request:" +
        "\n\nServer status:\n" + ajax.status + " " + ajax.statusText +
        "\n\nServer response text:\n" + ajax.responseText);
    if (exception) {
        throw exception;
    }
}

function changeBooksListByCategoryXML(responseXML) {
    /*  XML 구조에 대해 알기
        children, root 등.
        Node 를 생성해서 기존 Element에 삽입하기
        XML 파싱하기 (태그이름, 반복, ...)
     */
    let booksList = $("books");
    booksList.innerHTML = null;

    let books = responseXML.children[0].children;
    for (let i = 0; i < books.length; i++) {
        let book = books[i];
        let listNode = document.createElement("li");
        let textNode = document.createTextNode("");
        let book_contents = book.children;
        for (let j = 0; j < book_contents.length; j++) {
            let textContent = book_contents[j].textContent;
            let book_key = book_contents[j]["tagName"];
            if (book_key === "title") {
                textNode.appendData(textContent);
            } else if (book_key === "author") {
                textNode.appendData(", by " + textContent);
            }
        }
        listNode.appendChild(textNode);
        booksList.appendChild(listNode);
    }
}

function changeBooksListByCategoryJSON(responseJSON) {
    let booksList = $("books");
    booksList.innerHTML = "";
    let books = responseJSON["books"][0];
    console.log(books);

    for (let i = 0; i < books.length; i++) {
        let title = books[i]["title"];
        let author = books[i]["author"];

        let listNode = document.createElement("li");
        let textNode = document.createTextNode(title + ", by " + author);
        listNode.appendChild(textNode);
        booksList.appendChild(listNode);
    }


}


function getCategory() {
    let inputButtons = $$("#category label input");
    var category = "";
    for (let i = 0; i < inputButtons.length; i++) {
        let button = inputButtons[i];
        if (button.checked) {
            category = button.value.toLowerCase();
            console.log("category", category)
        }
    }
    return category;
}

window.onload = function () {
    $("b_xml").onclick = function () {
        //construct a Prototype Ajax.request object
        let category = getCategory();

        new Ajax.Request("books.php", {
            method: "get",
            parameters: {
                category: category
            },
            onSuccess: (res) => {
                alert(res.responseText);
                resXML = res.responseXML;
                changeBooksListByCategoryXML(resXML);
            },
            onFailure: ajaxFailed,
            onException: ajaxFailed
        })
    };
    $("b_json").onclick = function () {
        //construct a Prototype Ajax.request object
        let category = getCategory();
        let showBooks_JSON = (res) => {
            // Pretty 기능은 이미 내장되어 있더라.
            let responseJSON = JSON.stringify(res.responseJSON, null, 2);
            alert(responseJSON);
            changeBooksListByCategoryJSON(res.responseJSON);
        };
        new Ajax.Request("books_json.php", {
            method: "get",
            parameters: {category: category},
            onSuccess: showBooks_JSON,
            onFailure: ajaxFailed,
            onException: ajaxFailed
        })
    }
};

function getCheckedRadio(radio_button) {
    for (var i = 0; i < radio_button.length; i++) {
        if (radio_button[i].checked) {
            return radio_button[i].value;
        }
    }
    return undefined;
}

function showBooks_XML(ajax) {
    alert(ajax.responseText);
}

function showBooks_JSON(ajax) {
    alert(ajax.responseText);
}

function ajaxFailed(ajax, exception) {
    var errorMessage = "Error making Ajax request:\n\n";
    if (exception) {
        errorMessage += "Exception: " + exception.message;
    } else {
        errorMessage += "Server status:\n" + ajax.status + " " + ajax.statusText +
            "\n\nServer response text:\n" + ajax.responseText;
    }
    alert(errorMessage);
}

