import React from 'react';

const Home = () => {
  return (
    <div className="hero-section">
      <div className="container">
        <div className="hero-content">
          <h1>⚡ منصة الفولت في الفيزياء</h1>
          <p>مع مستر السيد محمد - أفضل منصة تعليمية للفيزياء في مصر</p>
          <div>
            <a href="/courses" className="btn btn-primary">تصفح الكورسات</a>
            <a href="/login" className="btn">تسجيل الدخول</a>
          </div>
          <div style={{marginTop: '3rem', fontSize: '0.9rem', opacity: 0.8}}>
            تطوير: Abdulrahman Ghonaim
          </div>
        </div>
      </div>
    </div>
  );
};

export default Home;