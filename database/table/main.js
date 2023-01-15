fetch("https://jsonplaceholder.typicode.com/users")
.then(response => response.json())
.then(json => data(json));

  const data = json =>{
    json = json.map(x=>{
      delete x["company"];
      delete x["address"];
      return x;
    });
    getHeader(Object.keys(json[0]));
    getTableData(json);
  };


const getHeader = fields =>{

    const table = document.querySelector('.table');
    const thead = document.createElement('thead');
    const tr = document.createElement("tr");
    const fragment = document.createDocumentFragment();

    fields.forEach( x =>{
      const th = document.createElement('th');
      th.innerText = x;
      fragment.appendChild(th);
    });
    tr.appendChild(fragment);
    thead.appendChild(tr);
    table.appendChild(thead);

  };


const getTableData = data =>{
  console.log(data);
  const table = document.querySelector('.table');
  const tbody = document.createElement('tbody');
  data.forEach(x => {

    const tr = document.createElement("tr");
    const fragment = document.createDocumentFragment();
    const keys = Object.keys(data[0]);
    keys.forEach( y =>{
      const td = document.createElement('td');
      td.innerText = x[y];
      fragment.appendChild(td);
    });
    tr.appendChild(fragment);
    tbody.appendChild(tr);
    table.appendChild(tbody);

  });
}