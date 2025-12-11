import React from 'react';

const Courses = () => {
  const courses = [
    {
      id: 1,
      title: "أساسيات الميكانيكا",
      description: "كورس شامل لأساسيات الميكانيكا للصف الأول الثانوي",
      price: "300 جنيه"
    },
    {
      id: 2,
      title: "الكهرباء والمغناطيسية",
      description: "كورس متقدم في الكهرباء والمغناطيسية",
      price: "450 جنيه"
    },
    {
      id: 3,
      title: "البصريات والضوء",
      description: "دراسة شاملة للبصريات والضوء",
      price: "350 جنيه"
    }
  ];

  return (
    <div className="page-container">
      <div className="container">
        <h1 className="page-title">كورسات الفيزياء</h1>
        <div className="courses-grid">
          {courses.map(course => (
            <div key={course.id} className="course-card">
              <h3>{course.title}</h3>
              <p>{course.description}</p>
              <div style={{marginTop: '1rem', fontWeight: 'bold'}}>
                {course.price}
              </div>
              <a href={`/course/${course.id}`} className="btn" style={{marginTop: '1rem', display: 'inline-block'}}>
                عرض التفاصيل
              </a>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Courses;