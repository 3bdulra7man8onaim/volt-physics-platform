import React, { useState } from 'react';

const Login = () => {
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('تم تسجيل الدخول بنجاح!');
  };

  return (
    <div className="page-container">
      <div className="container">
        <h1 className="page-title">تسجيل الدخول</h1>
        <form className="login-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label>البريد الإلكتروني:</label>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              placeholder="أدخل بريدك الإلكتروني"
              required
            />
          </div>
          <div className="form-group">
            <label>كلمة المرور:</label>
            <input
              type="password"
              name="password"
              value={formData.password}
              onChange={handleChange}
              placeholder="أدخل كلمة المرور"
              required
            />
          </div>
          <button type="submit" className="btn btn-primary" style={{width: '100%'}}>
            تسجيل الدخول
          </button>
          <div style={{textAlign: 'center', marginTop: '1rem'}}>
            <a href="/register" style={{color: 'rgba(255,255,255,0.8)'}}>
              إنشاء حساب جديد
            </a>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;