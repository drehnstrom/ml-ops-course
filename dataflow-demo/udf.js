function transform(inJson) {
    var obj = JSON.parse(inJson);
  
      // Convert each string property to Upper Case
    for (key in obj) {
      if (typeof obj[key] === 'string')
        obj[key] = obj[key].toUpperCase();
    }
    return JSON.stringify(obj);
}