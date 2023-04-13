export default function makeCalculatorDraggable(params) {
  let calculator = params;
  let isDragging = false;
  let currentX;
  let currentY;
  let initialX;
  let initialY;
  let xOffset = 0;
  let yOffset = 0;

  calculator.addEventListener("mousedown", dragStart);
  calculator.addEventListener("mouseup", dragEnd);
  calculator.addEventListener("mousemove", drag);

  function dragStart(event) {
    initialX = event.clientX - xOffset;
    initialY = event.clientY - yOffset;
    if (event.target === calculator) {
      isDragging = true;
    }
  }

  function dragEnd(event) {
    initialX = currentX;
    initialY = currentY;
    isDragging = false;
  }

  function drag(event) {
    if (isDragging) {
      event.preventDefault();
      currentX = event.clientX - initialX;
      currentY = event.clientY - initialY;
      xOffset = currentX;
      yOffset = currentY;
      setTranslate(currentX, currentY, calculator);
    }
  }

  function setTranslate(xPos, yPos, el) {
    el.style.transform = "translate3d(" + xPos + "px, " + yPos + "px, 0)";
  }
}