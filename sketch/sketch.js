// create a 16 x 16 grid using divs
// 1. Use a for loop to create divs side by side
// 2. Use a for loop for the rows
// 3. combine the two for loops so that 1 makes 16 divs side by side
//      and the other makes new rows



const grid = document.querySelector("#grid");

sketchPad(16);

function sketchPad(size) {

    let gridSize = size;

    for (let j = 0; j < gridSize; j++) {

        const row = document.createElement("div");
        row.classList.add("row");
        row.setAttribute("style", "display: flex; width: 100%; height: 100%; ");
        grid.appendChild(row);

        for (let i = 0; i < gridSize; i++) {
            const column = document.createElement("div");
            column.classList.add("column");
            column.setAttribute("style", "display: flex; width: 100%; height: 100%; outline: 1px solid red;");
            row.appendChild(column);
        }

    }



}


const box = document.getElementById("grid");

// This handler will be executed every time the cursor
// is moved over a different list item
box.addEventListener(
    "mouseover",
    (event) => {
        // highlight the mouseover target
        event.target.style.background = "orange";
    },
    false,
);

box.addEventListener(
    "mouseout",
    (event) => {
        // highlight the mouseover target
        event.target.style.background = "";
    },
    false,
);




const cBtn = document.getElementById("clearBtn");

// This handler will be executed every time the cursor
// is moved over a different list item
cBtn.addEventListener(
    "mouseover",
    (event) => {
        // highlight the mouseover target
        event.target.style.background = "orange";
    },
    false,
);

cBtn.addEventListener(
    "mouseout",
    (event) => {
        // highlight the mouseover target
        event.target.style.background = "";
    },
    false,
);


function clearGrid() {

 grid.replaceChildren();

    let size = prompt("What size grid would you like to make? (max: 100): ")

    if(size > 100){
        alert("Hey! I thought I told you the maximum number is 100! PAY ATTENTION!!")
        sketchPad(16);
    }else {

        return sketchPad(size);
    }
}


