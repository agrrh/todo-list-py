export function dateDiffHuman(datetime) {
  let now = Date.now()
  let then = Date.parse(datetime)

  let d1 = new Date()
  let tz_offset = d1.getTimezoneOffset() * 60

  seconds = (now - then) / 1000 + tz_offset

  function numberEnding (number) {
      return (number > 1) ? 's' : '';
  }

  var years = Math.floor(seconds / 31536000);
  if (years) {
      return years + ' year' + numberEnding(years);
  }
  //TODO: Months! Maybe weeks?
  var days = Math.floor((seconds %= 31536000) / 86400);
  if (days) {
      return days + ' day' + numberEnding(days);
  }
  var hours = Math.floor((seconds %= 86400) / 3600);
  if (hours) {
      return hours + ' hour' + numberEnding(hours);
  }
  var minutes = Math.floor((seconds %= 3600) / 60);
  if (minutes) {
      return minutes + ' minute' + numberEnding(minutes);
  }
  var seconds = seconds % 60;
  if (seconds) {
      return 'seconds';
  }
  return 'seconds';
}
