import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const selects = $('.select2');
  console.log(selects);

  selects.select2({
    placeholder: "Search for a city"
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };