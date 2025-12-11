import React from 'react';

const Admin = () => {
  return (
    <div className="page-container">
      <div className="container">
        <h1 className="page-title">لوحة الإدارة</h1>
        <div className="admin-dashboard">
          <div className="course-card">
            <h3>إدارة الكورسات</h3>
            <p>إضافة وتعديل الكورسات التعليمية</p>
            <button className="btn btn-primary">إدارة الكورسات</button>
          </div>
          <div className="course-card">
            <h3>إدارة الطلاب</h3>
            <p>عرض ومتابعة الطلاب المسجلين</p>
            <button className="btn btn-primary">إدارة الطلاب</button>
          </div>
          <div className="course-card">
            <h3>الإحصائيات</h3>
            <p>عرض إحصائيات المنصة والأداء</p>
            <button className="btn btn-primary">عرض الإحصائيات</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Admin;