import React from 'react';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import axios from 'axios'
import { Button, Label, FormGroup, Form, Input, Row, Col } from "reactstrap";

const defaultState = {
  text: "",
  type: "",
  message: "",
  root: {
    maxWidth: 645,
    background: 'rgba(0,0,0,0.5)',
    margin: '20px',
  },
  media: {
    height: 440,
  },
  title: {
    fontFamily: 'Nunito',
    fontWeight: 'bold',
    fontSize: '2rem',
    color: '#fff',
  },
  desc: {
    fontFamily: 'Nunito',
    fontSize: '1.1rem',
    color: '#ddd',
    width: 800
  },
  form: {
    width: 500,
    height: 50,
  }
}

const checkUrl = `${process.env.REACT_APP_API_URL}/validity/checkUrl`
const checkEmail = `${process.env.REACT_APP_API_URL}/validity/checkEmail`


class UrlCard extends React.Component {
  constructor(props) {
    super(props)
    this.state = defaultState
    this.handleInputChange = this.handleInputChange.bind(this)
    this.handleRadioButton = this.handleRadioButton.bind(this)
  }

  handleInputChange(event) {
    const target = event.target
    var value = target.value
    const name = target.name
    this.setState({
      [name]: value
    });
    console.log(event.target)
  }

  // Update type of request based on change in radio button selection
  handleRadioButton(event) {
    console.log(this.state.type)
    const target = event.target
    var value = target.value
    this.setState({
      type: value
    });
    console.log(value)
  }

  // Submit request
  submit() {
    if (this.state.type != "") {
      const requestBody = {
        text: this.state.text
      }
      var url = checkEmail

      if (this.state.type == "url") {
        url = checkUrl
      }
      axios.post(url, requestBody, {}).then(res=> {
        console.log(res)
          let message = res.data
          this.setState({message})
      }).catch(err => {
        console.log("An error occured while trying to post requests.")
      })
    } else {
      let message = "Please select an option by checking a radio button."
      this.setState({message})
    }
    
  }

  // Clear all inputs from the user
  clearData() {
    this.setState({
      text: "",
      message: ""
    })
  }

  render() {
    return (
      <Card className={this.state.root}>
        <CardContent>
          <Typography
            gutterBottom
            variant="h5"
            component="h1"
            className={this.state.title}>
            EMAIL OR URL VALIDATOR
          </Typography>
          
          <Typography
            variant="body2"
            color="textSecondary"
            component="p"
            className={this.state.desc} >
              <Form>
                    <Row> 
                      <Col md="12">
                        <FormGroup>
                          <Input
                            type="textarea"
                            name="text"
                            cols="70"
                            rows="3"
                            placeholder="Enter text"
                            value={this.state.text} 
                            onChange={this.handleInputChange}/>
                        </FormGroup>
                        <FormGroup tag="fieldset">
                        <legend>Select Type</legend>
                        <FormGroup check>
                          <Label check>
                            <Input type="radio" name="validity" value="url" onChange={this.handleRadioButton}/> Validate URL
                          </Label>
                        </FormGroup>
                        <FormGroup check>
                          <Label check>
                            <Input type="radio" name="validity" value="email" onChange={this.handleRadioButton}/> Validate Email
                          </Label>
                        </FormGroup>
                      </FormGroup>
                      </Col>
                    </Row>
                    <Row>
                      <Button
                        className="btn-round"
                        color="danger"
                        onClick={()=>this.submit()}>
                        Validate
                      </Button>
                      <Button
                        className="btn-round"
                        color="danger"
                        onClick={()=>this.clearData()}>
                        Clear
                      </Button>
                    </Row>
                  </Form>
                  <div><br/>{this.state.message}</div>
          </Typography>
        </CardContent>
      </Card>
    
  );
  }
}

export default UrlCard