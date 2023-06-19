const elem = document.getElementById('role_role');


client = document.getElementById("renter_attributes")
user=document.getElementById("user_attributes")

client.style.display="none"
user.style.display="none"

elem.addEventListener('change',drop)

function drop() {
      if (elem.value == 'Renter') {
          client.style.display="block"
          user.style.display='none'
      }
      else if(elem.value == 'Owner'){
          user.style.display='block'
          client.style.display="none"

      } else{
        client.style.display="none"
        user.style.display='none'
      }

  }