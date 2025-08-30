import React from 'react'
import Navbar from './Navbar'
import Hero from './Hero'
import AboutUs from './AboutUs'
import ContactForm from './ContactForm'
import Footer from './Footer'

const LandingPage = ({ navigate }) => {
  return (
    <div className="min-h-screen">
      <Navbar navigate={navigate} />
      <Hero navigate={navigate} />
      <AboutUs />
      <ContactForm />
      <Footer />
    </div>
  )
}

export default LandingPage
