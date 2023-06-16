const elem = document.getElementById('role_role');


client = document.getElementById("renter_attributes")

client.style.display="none"
elem.addEventListener('change',drop)

function drop() {
      if (elem.value == 'Renter') {
          client.style.display="block"
      } else{
        client.style.display="none"
       
      }

  }