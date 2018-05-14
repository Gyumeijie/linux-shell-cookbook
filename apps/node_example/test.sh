#!/bin/bash

for i in {1..10}; 
do node -e '
  "use strict";
   var sayHello = require("./hello.js").default;
   sayHello("node");'; 
done
