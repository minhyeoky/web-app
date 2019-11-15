"use strict";
// alert("Hello, world");

function bling() {
    alert(`bling`);
    let BlingButton = document.getElementById(`bling`);
    var TextArea = document.getElementById(`Text`);
    if (BlingButton.checked == true) {
        console.log(`checked true`);
        TextArea.style.color = `green`;
        TextArea.style.textDecoration = `underline`;
        document.body.style.backgroundImage = "url('https://selab.hanyang.ac.kr/courses/cse326/2019/labs/images/8/hundred.jpg')"

    } else {
        console.log(BlingButton.checked);
        TextArea.style.color = `black`;
        TextArea.style.textDecoration = `none`;
    }
}

function izzle() {
    var Text = document.getElementById(`Text`);
    var text = Text.value.split(`.`);
    console.log(text);
    for (let index = 0; index < text.length; index++) {
        text[index] += `-izzle`
        console.log(text[index]);
    }
    text = text.join(` `);
    console.log(text);
    Text.value = text;
}

function snoopify() {
    console.log(`snoopify`);
    var TextArea = document.getElementById(`Text`);
    TextArea.value = TextArea.value.toUpperCase();

}


function biggerPimp() {
    var Text = document.getElementById(`Text`);
    var fontSize = Text.style.fontSize;

    if (fontSize == ``) {
        console.log(`first font size`);
        Text.style.fontSize = `24pt`;
    } else {
        fontSize = parseFloat(fontSize);
        console.log(fontSize)
        fontSize += 2;
        console.log(`next font size: ${fontSize}pt`);
        Text.style.fontSize = `${fontSize}pt`
    }
    setInterval(biggerPimp, 500);
}

function piglatin() {
    var Text = document.getElementById(`Text`);

    console.log(Text.value);
    var texts = Text.value;
    texts = texts.split(` `);
    console.log(texts[0][0]);
    for (let index = 0; index < texts.length; index++) {
        const element = texts[index];
        var temp = element;
        temp += element[0]
        temp += `ay`;
        temp = temp.slice(1)
        texts[index] = temp;
    }
    Text.value = texts.join(` `);


}

function Malkovitch() {
    var Text = document.getElementById(`Text`);

    console.log(Text.value);
    var texts = Text.value;
    texts = texts.split(` `);

    for (let index = 0; index < texts.length; index++) {
        const element = texts[index];
        if (element.length >= 5) {
            texts[index] = `Malkovitch`;
        }
    }
    Text.value = texts.join(` `);

}