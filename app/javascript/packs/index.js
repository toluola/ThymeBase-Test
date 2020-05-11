createTip = function (res) {
  let tooltipWrap = document.createElement("div");
  let comment = res.getAttribute("comment");
  let firstChild = document.body.firstChild;
  let padding = 5;
  let linkProps = res.getBoundingClientRect();
  let tooltipProps = tooltipWrap.getBoundingClientRect(); 
  let topPos = linkProps.top - (tooltipProps.height + padding);
  let leftPos = linkProps.left + 20;
  tooltipWrap.className = 'tooltip';
  tooltipWrap.appendChild(document.createTextNode(comment));
  firstChild.parentNode.insertBefore(tooltipWrap, firstChild);
  tooltipWrap.setAttribute('style','top:'+topPos+'px;'+'left:'+leftPos+'px;')
}

cancelTip = function (res) {
  document.querySelector(".tooltip").remove();
}
