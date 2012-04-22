module.exports = function(){
  alert('Long live the Programs!');
};
var Program = require('modules/program');

module.exports = function(){
  alert('Long live the Users');
  Program();
};

var self = 'application.js';
