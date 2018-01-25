import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

function classNames(classes) {
    return Object.entries(classes)
        .filter(([key, value]) => value)
        .map(([key, value]) => key)
        .join(' ');
}

function initialGrids() {
  return [
    {value: 'A', matched: false, flipped: false},
    {value: 'B', matched: false, flipped: false},
    {value: 'C', matched: false, flipped: false},
    {value: 'D', matched: false, flipped: false},
    {value: 'E', matched: false, flipped: false},
    {value: 'F', matched: false, flipped: false},
    {value: 'G', matched: false, flipped: false},
    {value: 'H', matched: false, flipped: false},
    {value: 'A', matched: false, flipped: false},
    {value: 'B', matched: false, flipped: false},
    {value: 'C', matched: false, flipped: false},
    {value: 'D', matched: false, flipped: false},
    {value: 'E', matched: false, flipped: false},
    {value: 'F', matched: false, flipped: false},
    {value: 'G', matched: false, flipped: false},
    {value: 'H', matched: false, flipped: false}
  ];
}


class Grind extends React.Component {
  constructor(props) {
    super(props);
    this.clickEvent = this.clickEvent.bind(this);
  }

  clickEvent(e) {
    if (!this.props.flipped) {
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
      <div className={classes} onClick={this.clickEvent}>
        {display}
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

    this.state = {
      grinds : initialGrids(),
      lastGrind : null,
      locked : false,
      matches : 0,
      tryTimes : 0
      };
  }


    restart() {
     this.setState({
      grinds : initialGrids(),
      lastGrind : null,
      locked : false,
      matches : 0,
      tryTimes : 0
}); }

    renderGrinds(grinds) {
        return grinds.map((grind, index) => {
            return (
                <Grind
                    key={index}
                    value={grind.value}
                    id={index}
                    matched={grind.matched}
                    flipped={grind.flipped}
                    checkEqual={this.checkEqual} />
            );
        });
    }




    checkEqual(value, id) {
    if (this.state.done) {
      return;
    }

    let grinds = this.state.grinds;
        grinds[id].flipped = true;
    this.setState({grinds, locked: true});
    if (this.state.lastGrind) {
      if (value === this.state.lastGrind.value) {
        let matches = this.state.matches;
        grinds[id].matched = true;
          grinds[this.state.lastCard.id].matched = true;
        this.setState({grinds, lastCard: null, locked: false, matches: matches + 1});
      } else {
        setTimeout(() => {
            grinds[id].flipped = false;
            grinds[this.state.lastCard.id].flipped = false;
          this.setState({grinds, lastCard: null, locked: false});
        }, 1000);
      }
    } else {
      this.setState({
        lastCard: {id, value},
        locked: false
      });
    }
  }



    render() {
        let btnText = 'Reset';
        if (this.state.matches === this.state.grinds.length / 2) {
            btnText = 'You Win! Play Again?';
        }
        return (
            <div className="Game">
                <div>
                    <button onClick={this.reset}>{btnText}</button>
                </div>
                {this.renderGrinds(this.state.grinds)}
            </div>
        );
    }


  }