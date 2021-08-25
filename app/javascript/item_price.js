window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const salesCommission = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = salesCommission.toLocaleString();
    const profit = document.getElementById("profit");
    profitResult = inputValue - salesCommission;
    profit.innerHTML = profitResult.toLocaleString();
  })
});