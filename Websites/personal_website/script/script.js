const courseList = [];

courseList[0] = {
    code: "ACIT 1620",
    name: "Web Fundamental Technologies"
};

courseList[1] = {
    code: "ACIT 1515",
    name: " Scripting for IT"
};

courseList[2] = {
    code: "ACIT 1630",
    name: "Database Systems"
};

let done = false;
let input;

while(!done){
    input = prompt("Enter a 4-digit course code");
    if(!isNaN(input) && input.length == 4)
        done = true;
}

let found = false;

for(let i=0; i < courseList.length; i++) {
    if(courseList[i].code.includes(input)) {
        console.log(`Yes I am taking the course: ${courseList[i].code} - ${courseList[i].name}`);
        found = true;
        break;
    }
}

if(!found){
	courseList.push({code: input, name: null})
	console.log("Course code "+input+" has been logged.");
}
