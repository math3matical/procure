function hello(name) {
    let greeting = "Hello, " + name + "!";
    console.log(greeting);
    alert(greeting);
}

document.addEventListener('turbolinks:load', () => {
    const clickButton = document.getElementById("greet-user-button");
    clickButton.addEventListener('click', (event) => {
        hello('JavaScript')
    });
});
