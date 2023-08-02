import { Controller } from "@hotwired/stimulus"
import { debounce } from "lodash";

// Connects to data-controller="search"
export default class extends Controller {
  // static targets = ["input", "results"];

  connect() {
    
    
    // this.debouncedInput = debounce(this.input, 500);
    // this.inputTarget.addEventListener("input", this.debouncedInput);
    
    // this.inputTarget.addEventListener("input", debounce(this.input, 1000));
    

  }

  disconnect() {
    //console.log("Search is disconnected")
    //this.inputTarget.removeEventListener("input", this.input);

    
  }


  debouncedFunction = debounce(() =>{
    console.log('Function debounced after 1000ms!');
    }, 1000);

    

  input =  async() => {
    const userInput = this.inputTarget.value.trim();
    console.log("User said:", userInput);
    

    try {
       const response = await fetch(`/search?search=${userInput}`);
        let data = await response.json();
        data = data.sort((a,b) => b.years - a.years)
        this.renderResults(data);

        console.log(data)
     
    } catch (error) {
      console.error("Error fetching search results:", error);
    }
  }
      // Update the results in the view
       
       renderResults(results) {
        this.resultsTarget.innerHTML = "";
        results.forEach((player) => {
          const row = document.createElement("tr");
          row.innerHTML = `
            <td class="text-left py-1 px-2 sticky left-0 bg-white">
              <a href="/players/${player.player_id}">${player.player.name}</a>
            </td>
          <td class="text-left py-1 px-2">${player.team}</td>
          <td class="text-left py-1 px-2">${player.years}</td>
          <td class="text-left py-1 px-2">${player.games}</td>
          <td class="text-left py-1 px-2">${player.atbat}</td>
          <td class="text-left py-1 px-2" id="hits">${player.hits}</td>
          <td class="text-left py-1 px-2">${ player.runs }</td>
          <td class="text-left py-1 px-2">${ player.singles }</td>
          <td class="text-left py-1 px-2">${ player.doubles }</td>
          <td class="text-left py-1 px-2">${ player.triples }</td>
          <td class="text-left py-1 px-2">${ player.homeruns }</td>
          <td class="text-left py-1 px-2">${ player.rbi }</td>
          <td class="text-left py-1 px-2">${ player.tb }</td>
          <td class="text-left py-1 px-2">${ player.k }</td>
          <td class="text-left py-1 px-2">${ player.sac }</td>
          <td class="text-left py-1 px-2">${ player.gwrbi }</td>
          <td class="text-left py-1 px-2">${ player.avg }</td>
          <td class="text-left py-1 px-2">${ player.obp}</td>
          <td class="text-left py-1 px-2">${ player.slg}</td>
          <td class="text-left py-1 px-2">${ player.ops}</td>
          `;
          this.resultsTarget.appendChild(row);
        })
       }
      
    catch (error) {
      console.error("Error fetching search results:", error);
    }
  };


