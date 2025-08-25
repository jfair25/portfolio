/* use an external javascript file for all of the javascript and have the html file link it so that the coding is cleaner */


function playGame(choice) {

    const uScore = document.querySelector("#uScore")
    const cScore = document.querySelector("#cScore")

    let humanscore = uScore.getAttribute("placeholder");
    let computerscore = cScore.getAttribute("placeholder");
    let noscore = tScore.getAttribute("placeholder");

    const action = document.querySelector("#action");
    const content = document.createElement("div");
    content.classList.add("content");
    content.setAttribute("style", "display: flex; flex-direction: column-reverse; padding-left: 8px; padding-right: 8px;");

    /* write a function  called getComputerChoice that randomly gernerates the computer choice and returns the choice of either rock paper or scissor 
    use the Math.random function to generate a random number
    1. if number >= 0 && <= 0.39 computer chooses rock
    2. if number > 0.39 and <= .69 computer chooses paper
    3. if number > .69 and <= 1 computer chooses scissor */


    function getComputerChoice() {
        const compChoice = Math.random()
        let compSelection = "none"

        if (compChoice >= 0 && compChoice <= 0.39) {
            compSelection = "rock"
        } else if (compChoice > 0.39 && compChoice <= 0.69) {
            compSelection = "paper"
        } else if (compChoice > 0.69 && compChoice <= 1) {
            compSelection = "scissors"
        }

        return compSelection;
    }

    /* Write a function that called getHumanChoice that prompts the user to pick either rock, paper or scissor. */
    /* use the prompt method to get the humans choice. assume that the human always chooses a valid option */

    function getHumanChoice(choice) {

        if (choice == 1) {
            const humSelection = "rock"
            return humSelection
        } else if (choice == 2) {
            const humSelection = "paper"
            return humSelection
        } else if (choice == 3) {
            const humSelection = "scissors"
            return humSelection
        }
    }




    /* create a function called playRound that takes parameters humanchoice and computerchoice
        use the two paramaters as arguments. */

    // make your functions human choice case insensitive so that any permatation of the choice is accepted
    // playRound should funtion to console.log so that the output displays a message of the results ie: You win! Rock crushes Scissors!
    // increment human score based on the winner

    function playRound(humanChoice, computerChoice) {


        if (computerChoice === "rock" && humanChoice === "scissors") {
            content.textContent = "***Computer choses " + computerChoice + "! " + "You LOSE! Rock crushes Scissors!";
            action.appendChild(content);
            computerscore++
            cScore.setAttribute("placeholder", computerscore);
        } else if (computerChoice === "paper" && humanChoice === "rock") {
            content.textContent = "***Computer choses " + computerChoice + "! " + "You LOSE! Paper smothers Rock!";
            action.appendChild(content);
            computerscore++
            cScore.setAttribute("placeholder", computerscore);
        } else if (computerChoice === "scissors" && humanChoice === "paper") {
            content.textContent = "***Computer choses " + computerChoice + "! " + "You LOSE! Scissors cut paper!";
            action.appendChild(content);
            computerscore++
            cScore.setAttribute("placeholder", computerscore);
        } else if (humanChoice === "rock" && computerChoice === "scissors") {
            content.textContent = "***Computer choses " + computerChoice + "! " + "You WIN! Rock smashes Scissors! CONGRATULATIONS!!!";
            action.appendChild(content);
            humanscore++
            uScore.setAttribute("placeholder", humanscore);
        } else if (humanChoice === "paper" && computerChoice === "rock") {
            content.textContent = "***Computer choses " + computerChoice + "! " + "You WIN! Paper smothers Rock! CONGRATULATIONS!!!";
            action.appendChild(content);
            humanscore++
            uScore.setAttribute("placeholder", humanscore);
        } else if (humanChoice === "scissors" && computerChoice === "paper") {
            content.textContent = "***Computer chooses " + computerChoice + "! " + "You WIN! Scissors cut Paper! CONGRATULATIONS!!!";
            action.appendChild(content);
            humanscore++
            uScore.setAttribute("placeholder", humanscore);
        } else {
            content.textContent = "***Computer chooses " + computerChoice + "! " + "Its a Tie! BOOOOOO! Nobody likes to tie!"
            action.appendChild(content);
            noscore++
            tScore.setAttribute("placeholder", noscore);
        }

    }

    const humanSelection = getHumanChoice(choice);
    const computerSelection = getComputerChoice();

    playRound(humanSelection, computerSelection);


    // write a function called playGame that calls function playRound 5 times.
    // move your playRound function and score variable so they are declared inside of the playGame function
    // play 5 rounds by calling playRound 5 times



}