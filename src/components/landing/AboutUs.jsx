import React from 'react'
import { motion } from 'framer-motion'
import { BarChart3, Users, Clock, Shield, Smartphone, Globe } from 'lucide-react'

const AboutUs = () => {
  const features = [
    {
      icon: BarChart3,
      title: "Advanced Analytics",
      description: "Get deep insights into your inventory with comprehensive reports and real-time analytics."
    },
    {
      icon: Users,
      title: "Team Collaboration",
      description: "Work seamlessly with your team using our collaborative tools and role-based access."
    },
    {
      icon: Clock,
      title: "Real-time Updates",
      description: "Stay updated with instant notifications and real-time synchronization across all devices."
    },
    {
      icon: Shield,
      title: "Enterprise Security",
      description: "Your data is protected with bank-level encryption and comprehensive security measures."
    },
    {
      icon: Smartphone,
      title: "Mobile Ready",
      description: "Access your inventory anywhere, anytime with our fully responsive web application."
    },
    {
      icon: Globe,
      title: "Global Scale",
      description: "Scale your business globally with multi-location support and international features."
    }
  ]

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2
      }
    }
  }

  const itemVariants = {
    hidden: { opacity: 0, y: 30 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.6
      }
    }
  }

  return (
    <section className="py-20 bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="text-center mb-16"
        >
          <h2 className="text-3xl md:text-4xl lg:text-5xl font-bold text-gray-900 mb-6">
            Why Choose{' '}
            <span className="bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
              StockHub
            </span>
            ?
          </h2>
          <p className="text-xl text-gray-600 max-w-3xl mx-auto">
            We're revolutionizing inventory management with cutting-edge technology, 
            intuitive design, and powerful features that scale with your business.
          </p>
        </motion.div>

        {/* Features Grid */}
        <motion.div
          variants={containerVariants}
          initial="hidden"
          whileInView="visible"
          viewport={{ once: true }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8"
        >
          {features.map((feature, index) => (
            <motion.div
              key={index}
              variants={itemVariants}
              className="group bg-white rounded-xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-2 border border-gray-100"
            >
              <div className="mb-6">
                <div className="w-16 h-16 bg-gradient-to-r from-blue-600 to-purple-600 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300">
                  <feature.icon className="h-8 w-8 text-white" />
                </div>
                <h3 className="text-xl font-bold text-gray-900 mb-3">
                  {feature.title}
                </h3>
                <p className="text-gray-600 leading-relaxed">
                  {feature.description}
                </p>
              </div>
            </motion.div>
          ))}
        </motion.div>

        {/* Stats Section */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8, delay: 0.4 }}
          className="mt-20 bg-gradient-to-r from-blue-600 to-purple-600 rounded-2xl p-8 md:p-12 text-white"
        >
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
            <div>
              <div className="text-3xl md:text-4xl font-bold mb-2">10K+</div>
              <div className="text-blue-100">Active Users</div>
            </div>
            <div>
              <div className="text-3xl md:text-4xl font-bold mb-2">1M+</div>
              <div className="text-blue-100">Items Managed</div>
            </div>
            <div>
              <div className="text-3xl md:text-4xl font-bold mb-2">99.9%</div>
              <div className="text-blue-100">Uptime</div>
            </div>
          </div>
        </motion.div>

        {/* Mission Statement */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8, delay: 0.6 }}
          className="mt-16 text-center bg-white rounded-2xl p-8 md:p-12 shadow-lg"
        >
          <h3 className="text-2xl md:text-3xl font-bold text-gray-900 mb-6">
            Our Mission
          </h3>
          <p className="text-lg text-gray-600 max-w-4xl mx-auto leading-relaxed">
            We believe that every business deserves access to powerful, intuitive inventory management tools. 
            Our mission is to simplify complex inventory processes, reduce operational costs, and help 
            businesses focus on what they do best - growing and serving their customers.
          </p>
        </motion.div>
      </div>
    </section>
  )
}

export default AboutUs
