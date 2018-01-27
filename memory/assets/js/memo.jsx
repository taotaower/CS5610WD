import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

function classNames(classes) {
    return Object.entries(classes)
        .filter(([key, value]) => value)
        .map(([key, value]) => key)
        .join(' ');
}



function shuffleArray(array) {
    let i = array.length - 1;
    for (; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

function initialGrids() {
  return [
    {id : 0, value: 'A', matched: false, flipped: false},
    {id : 1, value: 'B', matched: false, flipped: false},
    {id : 2, value: 'C', matched: false, flipped: false},
    {id : 3, value: 'D', matched: false, flipped: false},
    {id : 4, value: 'E', matched: false, flipped: false},
    {id : 5, value: 'F', matched: false, flipped: false},
    {id : 6, value: 'G', matched: false, flipped: false},
    {id : 7, value: 'H', matched: false, flipped: false},
    {id : 8, value: 'A', matched: false, flipped: false},
    {id : 9, value: 'B', matched: false, flipped: false},
    {id : 10, value: 'C', matched: false, flipped: false},
    {id : 11, value: 'D', matched: false, flipped: false},
    {id : 12, value: 'E', matched: false, flipped: false},
    {id : 13, value: 'F', matched: false, flipped: false},
    {id : 14, value: 'G', matched: false, flipped: false},
    {id : 15, value: 'H', matched: false, flipped: false}
  ];
}


class Grind extends React.Component {
  constructor(props) {
    super(props);
    this.clickEvent = this.clickEvent.bind(this);
  }

  clickEvent(e) {
     if(this.props.locked){
         return
     }

    if (!this.props.flipped) {
        console.log(this.props.flipped);
        console.log(this.props.id);
      this.props.checkEqual(this.props.value, this.props.id);
    }
  }

  render() {
    let classes = classNames(
        {

      'Grind': true,
      'Grind--flipped': this.props.flipped,
      'Grind--matched': this.props.matched,});

      let display = '';
    if (this.props.flipped){
        display = this.props.value
    }

    return (
        <div className='col' >

      <div className={classes} id={ this.props.id} onClick={this.clickEvent}>
       <label className="Character">
        {display}
       </label>
      </div>
        </div>

    );
  }
}

export default function run_demo(root) {
  ReactDOM.render(<Memo />, root);
  }
class Memo extends React.Component {
  constructor(props) {
    super(props);
    this.restart = this.restart.bind(this);
    this.renderGrinds = this.renderGrinds.bind(this);
    this.checkEqual = this.checkEqual.bind(this);
    let grinds = shuffleArray(initialGrids());
    grinds.map((grind,index) => {
        grind.id = index

      }
    );

    this.state = {
      grinds : grinds,
      lastGrind : null,
      locked : false,
      matches : 0,
      tryTimes : 0,
      };
  }


    restart() {
        let grinds = shuffleArray(initialGrids());
        grinds.map((grind,index) => {
                grind.id = index

            }
        );
     this.setState({
      grinds : grinds,
      lastGrind : null,
      locked : false,
      matches : 0,
      tryTimes : 0
}); }


    renderGrinds(grinds) {

        return grinds.map((grind, index) => {
                return (

                <Grind
                    value={grind.value}
                    id={grind.id}
                    matched={grind.matched}
                    flipped={grind.flipped}
                    locked = {this.state.locked}
                    checkEqual={this.checkEqual}/>
                    );
                });
    }

    checkEqual(value, id) {
    if (this.state.done) {
        console.log('done');
      return;
    }
    console.log('checking');
    let grinds = this.state.grinds;
        grinds[id].flipped = true;

    console.log('here here');
    this.setState({grinds, locked: true});
    console.log(this.state.lastGrind);

    if (this.state.lastGrind) {
        let tryTimes = this.state.tryTimes;
        this.setState({tryTimes : tryTimes + 1 });

      if (value === this.state.lastGrind.value) {

          console.log('value verify');
        let matches = this.state.matches;
        grinds[id].matched = true;
          grinds[this.state.lastGrind.id].matched = true;
        this.setState({grinds, lastGrind: null, locked: false, matches: matches + 1});
      } else {
        setTimeout(() => {
            grinds[id].flipped = false;
            grinds[this.state.lastGrind.id].flipped = false;
          this.setState({grinds, lastGrind: null, locked: false});
        }, 1000);
      }
    }
    else {

        console.log(id,value);
      this.setState({
        lastGrind: {id, value},
        locked: false,
      });
    }
  }



    render() {
        let btnText = 'Restart';
        if (this.state.matches === this.state.grinds.length / 2) {
            btnText = 'Another round? click me';
        }
        return (
            <div className="Game">
                <div className="row">
                    <div className="col">
                <Button className="Reset" onClick={this.restart}>{btnText}</Button>
                    </div>
                    <div className="col">
                    <label> You tried <label className ="tryTimes">{this.state.tryTimes} </label> time(s)</label>

                    </div>
                    <div className="col">
                        <label> You got <label className ="matches">{this.state.matches} </label> match(es)</label>

                    </div>

                    <div className="col">
                        <label> Your score is  &nbsp;&nbsp;<label className ="scores">  {this.state.matches * 4 - this.state.tryTimes}  </label> &nbsp;&nbsp;!</label>

                    </div>

                </div>

                <div className='panel'>
                <div className="container">
                 <div className="row">
                {this.renderGrinds(this.state.grinds.slice(0, 4))}
                 </div >
                    <div className="row">
                    {this.renderGrinds(this.state.grinds.slice(4, 8))}
                    </div>
                    <div className="row">
                    {this.renderGrinds(this.state.grinds.slice(8, 12))}
                    </div>
                    <div className="row">
                    {this.renderGrinds(this.state.grinds.slice(12, 16))}
                    </div>
                </div>
                </div>

            </div>
        );
    }


  }