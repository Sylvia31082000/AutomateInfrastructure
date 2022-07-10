import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import UrlCard from './UrlCard';
const useStyles = makeStyles((theme) => ({
  root: {
    minHeight: '100vh',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    [theme.breakpoints.down('md')]: {
      flexDirection: 'column',
    },
  },
}));

export default function () {
  const classes = useStyles();
  return (
    <div className={classes.root} id="bottom">
      <UrlCard />
     </div>
  );
}
