function getJSON() {

    document.getElementById("generate-btn").style.display = "none";
    var rbox = document.getElementsByClassName("report-box");
    rbox[0].style.visibility = "visible";

    if (localStorage.getItem("courses") === null) {
      window.location="http://159.89.116.235/uploadTest.php";
    }

    var degree = '{"degree": "Honours BSc.Computing Systems","required": ["COIS 1010H","COIS 1020H", "COIS 2020H", "COIS 2240H","COIS 2300H","COIS 3020H","COIS 3380H","COIS 3400H","MATH 1350H","MATH 1550H"],"options": [{"id": 1, "choice": ["MATH 1005H","MATH 1100H","MATH 1100Y","MATH 1101Y"]}],"req_credits": [{"num": 2,"type": "COIS","level": 4},{"num": 2.5,"type": "COIS","level": 3},{"num": 2,"type": "COIS","level": 0}],"science_credits": 14}';

    var transcript = localStorage.getItem("courses");

    var sc_credits = '{ "sc_credits": ["ANTH 3540H","ANTH 1001H","ANTH 2121H","ANTH 2122H","ANTH 2410H","ANTH 2450H","ANTH 3112H","ANTH 3180H","ANTH 3151H","ERSC 3333H","FRSC 3404H","FRSC 3405H","BIOL 3470H","AHCL 3540H","ANTH 3731H","ANTH 3995H","ANTH 4150H","ANTH 4420H","ANTH 4430H","SAFS 4440H","ANTH 4710H","ANTH 4450H","BIOL 1020H","BIOL 1051H","BIOL 1550H","BIOL 2000H","FRSC 2050H","BIOL 2070H","BIOL 2100H","BIOL 1050H","BIOL 2110H","ERSC 2260H","BIOL 2290H","CHEM 2300H","BIOL 2600H","FRSC 3000H","BIOL 3040H","BIOL 3051H","BIOL 3080H","BIOL 3090H","BIOL 3100H","BIOL 3140H","BIOL 3170H","BIOL 3180H","BIOL 3190H","PSYC 3220H","SAFS 3240H","BIOL 3250H","CHEM 3320H","FRSC 3330H","BIOL 3050H","PSYC 3360H","ERSC 3380H","FRSC 3404H","ANTH 3470H","BIOL 3500H","BIOL 3600H","BIOL 3640H","BIOL 3830H","BIOL 3840H","BIOL 3340H","BIOL 4080H","BIOL 4110H","BIOL 4140H","BIOL 4150H","BIOL 4160H","BIOL 4180H","BIOL 4190H","BIOL 4210H","BIOL 4010Y","BIOL 4020D","BIOL 4010Y, 4020D","BIOL 4260H","CHEM 4300H","BIOL 4320H","BIOL 4340H","BIOL 4355H","BIOL 4370H","BIOL 4380H","ERSC 4390H","BIOL 4500H","BIOL 4520H","BIOL 4610H","BIOL 4630H","FRSC 4800H","PSYC 4840H","FRSC 4570H","FRSC 4600H","CHEM 1000H","CHEM 1010H","CHEM 2200H","BIOL 2300H","CHEM 2400H","CHEM 3120H","BIOL 3320H","FRSC 3400H","CHEM 4140H","CHEM 4200H","CHEM 4220H","BIOL 4300H","CHEM 4400H","CHEM 4500H","FRSC 4710H","CHEM 4900Y","CHEM 4901H","CHEM 4902H","CHEM 4900Y, 4901H, 4902H","MATH 1080H","COIS 1010H","COIS 2020H","COIS 2240H","PHYS 2250H","COIS 2300H","PHYS 2310H","COIS 2320H","PHIL 2410H","MATH 2600H","COIS 2830H","COIS 3020H","COIS 3400H","COIS 3050H","COIS 3420H","PHYS 3200Y","MATH 3350H","COIS 3380H","COIS 3510H","COIS 3560H","COIS 3860H","COIS 3901H","COIS 4000Y","COIS 4050H","MATH 4215H","COIS 4310H","COIS 4350H","COIS 4400H","COIS 4470H","COIS 3820H","COIS 4550H","COIS 4600H","COIS 4850H","COIS 4480H","ECON 1010H","ECON 1020H","ECON 3120H","ECON 3160H","ECON 3200H","ECON 3210H","ECON 3410H","ECON 3510H","ECON 3110H","ECON 4200H","ECON 4010Y","ERST 3810H","BIOL 2260H","ERSC 2300H","SAFS 2350H","GEOG 2401H","GEOG 2530H","ANTH 3333H","BIOL 3380H","FRSC 3400H","ERSC 3450H","ERSC 3551H","SAFS 3560H","PSYC 3710H","ECON 3810H","ERSC 4350H","BIOL 4390H","ERSC 4520H","GEOG 3002H","FRSC 1010H","BIOL 2050H","FRSC 2220H","FRSC 2400H","BIOL 3000H","FRSC 3010H","FRSC 3100H","BIOL 3330H","ERSC 3400H","BIOL 3404H","ANTH 3405H","FRSC 3800H","FRSC 4010Y","FRSC 4020D","FRSC 4111H","FRSC 3111H","BIOL 4570H","BIOL 4600H","CHEM 4710H","BIOL 4800H","PSYC 3796H","PSYC 4796H","EGEO 3002H","ERSC 2401H","GEOG 2460H","ERSC 2530H","GEOG 2540H","GEOG 3440H","GEOG 3520H","GEOG 3530H","SAFS 3560H","GEOG 3420H","GEOG 3590H","GEOG 3860H","GEOG 4090H","GEOG 4080H","GEOG 4010Y","GEOG 4020D","GEOG 4010Y, 4020D","COIS 1010H","MATH 1001H","MATH 1005H","CCTH 1080H","MATH 1120H","MATH 2350H","MATH 2120H","MATH 2200H","COIS 2600H","PHYS 3130H","MATH 1350H","MATH 3260H","COIS 3350H","MATH 3510H","MATH 3610H","MATH 3700H","MATH 3770H","MATH 3790H","MATH 3200H","MATH 4120H","MATH 4180H","COIS 4215H","MATH 4310H","MATH 4400H","MATH 4560H","MATH 4610H","MATH 4800H","MATH 4810H","MATH 4900Y","MATH 4903H","MATH 4904H","MATH 4900Y, 4903H, 4904H","MATH 4620H","NURS 1001H","NURS 2021H","NURS 2001H","NURS 2550H","NURS 3000H","NURS 3001H","NURS 3005H","NURS 4011H","NURS 4012H","NURS 4103H","NURS 4201H","NURS 4203H","NURS 4900H","NURS 4205H","PSYC 2270H","COIS 2410H","PHIL 2780H","PSYC 3020H","PHYS 1001H","PHYS 1002H","BIOL 1060H","PHYS 1510H","PHYS 1520H","COIS 2250H","COIS 2310H","PHYS 2700H","MATH 3130H","COIS 3200Y","PHYS 3900Y","PHYS 3901H","PHYS 3900Y, 3901H","PHYS 4000Y/4010H","PHYS 4220H","PHYS 4240H","PHYS 2610H","PHYS 4610H","PHYS 4700H","PHYS 4900Y","PHYS 4901H","PHYS 4900Y, 4901H","PHYS 4310H","PSYC 2200H","PSYC 2210H","PSYC 2300H","PSYC 2500H","PSYC 2600H","PHIL 3020H","PSYC 3110H","BIOL 3220H","PSYC 3230H","PSYC 3240H","PSYC 3300H","BIOL 3360H","PSYC 3420H","PSYC 3451H","PSYC 3460H","PSYC 3530H","PSYC 3560H","PSYC 3590H","PSYC 3610H","ERSC 3710H","PSYC 3730H","WMST 3740H","PSYC 3750H","PSYC 3430H","PSYC 3770H","PSYC 3780H","WMST 3796H","PSYC 3801H","PSYC 3802H","PSYC 3900Y","PSYC 3901H","PSYC 3902H","PSYC 3900Y, 3901H, 3902H","PSYC 4010Y","PSYC 4020D","PSYC 4010Y, 4020D","PSYC 4130H","PSYC 3760H","PSYC 4310H","PSYC 4430H","PSYC 4560H","PSYC 4590H","PSYC 4170H","PSYC 4720H","PSYC 4740H","PSYC 4802H","BIOL 4840H","PSYC 4900Y","PSYC 4901H","PSYC 4902H","PSYC 4900Y, 4901H, 4902H","PSYC 4760H","PSYC 4780H","WMST 4796H","PSYC 4801H","ERSC 2350H","BIOL 3240H","GEOG 3560H","ANTH 4440H"]}';

    var degreeObj = JSON.parse(degree);
    var transcriptObj = JSON.parse(transcript);
    var scCreditsObj = JSON.parse(sc_credits);
    document.getElementById('degreeName').innerHTML = degreeObj.degree;

    var required_courses = [];

    degreeObj.required.forEach( function (element) {
      required_courses.push(element);
    });

    var average = 0;
    var completed_creds = 0;
    var course;
    var sc_courses = 0;
    var required_sc = degreeObj.science_credits;
    var fifties = 0;
    var year_one_creds = 0;

    var course_choices = new Array();

    degreeObj.options.forEach( function (element) {

          course_choices[element.id] = element.choice;

        });

    transcriptObj.Credits.forEach( function (element) {

      if (element.CODE.charAt(0) == '1') {
        year_one_creds += parseFloat(element.CREDS);
      }

      course = element.DEPT + " " + element.CODE;

      if (sc_credits.includes(course)) {
              sc_courses++;
            }

      if (required_courses.includes(course)) {

          if (element.GRADE != "INP") {
            average += element.GRADE;
            completed_creds++;

            if (element.GRADE > 49 && element.GRADE < 60) {
              fifties++;
            }
          }

            addToList(course,"complete");

            var index = required_courses.indexOf(course);
            required_courses.splice(index, 1);

        }

        var choice_num = 1;

        course_choices.forEach( function (element) {

          if (element.indexOf(course) > -1) {
            addToList(course,"complete");
            delete course_choices[choice_num];
          }
          choice_num++;
        });
    });

    required_courses.forEach( function (element) {
          addToList(element,"incomplete");
      });

    reqCredits(degreeObj.req_credits, transcriptObj.Credits);

    if (required_sc < sc_courses) {
      addToList(required_sc + " Sc. Credits","unireq-complete");
    }
    else {
      addToList(required_sc + " Sc. Credits","unireq-incomplete");
    }

    if (fifties > 2) {
      addToList(fifties +" D-Grades","unireq-incomplete");
    }
    else {
      addToList(fifties +" D-Grades","unireq-complete");
    }

    if (year_one_creds > 7.0) {
      addToList("More than 7.0 1000 Level Credits","unireq-incomplete");
    }
    else {
      addToList("< 7.5 1000 Credits","unireq-complete");
    }

    average = Math.round(average / completed_creds);
    
    if (average < 65) {
      addToList("Average < 65%","unireq-incomplete");
    }
    else {
      addToList("Average > 65%","unireq-complete");
    }
  }

function addToList(course, list) {
  var node = document.createElement("li"); 
  node.id = course;        
  node.classList.add("col-md-4");      
  var textnode = document.createTextNode(course);         
  node.appendChild(textnode);                              
  document.getElementById(list).appendChild(node);
}

function reqCredits(req_credits, complete_credits) {

  var cred_list = new Array();
  var cred_list_details = new Array();

  req_credits.forEach( function (element) {

    if (element.level != 0) {
      cred_list[element.type + String(element.level)] = element.num;
      cred_list_details[element.type + String(element.level)] = String(element.num) + " " + element.type + " " + element.level + "000 Credits";
    }
    else {
      cred_list[element.type] = element.num;
      cred_list_details[element.type] = String(element.num) + " " + element.type + " Credits";
    }
  });

  complete_credits.forEach( function (element) {

    var code = element.DEPT + String(element.CODE.charAt(0)); 

    if (code in cred_list) {
      cred_list[code] -= parseFloat(element.CREDS);
      if (cred_list[code] <= 0) {
        console.log("Requirement met for " +code);
        addToList(cred_list_details[code], "complete");
        delete cred_list[code];
      }
    }
    else if(element.DEPT in cred_list) {
      cred_list[element.DEPT] -= parseFloat(element.CREDS);
      if (cred_list[element.DEPT] <= 0) {
        console.log("Requirement met for " +element.DEPT);
        addToList(cred_list_details[element.DEPT], "complete");
        delete cred_list[element.DEPT];
      }
    }
  });
}