import React from "react";

const Mfooter = () => {
    return (
        <div style={{ textAlign: 'center', zIndex: 251, position: 'absolute', bottom: 0, width: 480, height: 100, background: 'white', boxShadow: '0 0 2px 2px #ccc', fontSize: 0 }}>
            <div style={{ width: 80, height: 90, display: 'inline-block', margin: '0 14px', cursor: 'pointer' }} onClick={() => window.location.href = "/tip"}>
                <i className="bi bi-clipboard2-check" style={{ fontSize: 50, color:"#999" }}></i>
                <div style={{ fontSize: 16, fontWeight: 'bold', color:"#999" }}>TIP♡</div>
            </div>
            <div style={{ width: 80, height: 90, display: 'inline-block', margin: '0 14px', cursor: 'pointer' }} onClick={() => window.location.href = "/premium"}>
                <i className="bi bi-people" style={{ fontSize: 50, color:"#999" }}></i>
                <div style={{ fontSize: 16, fontWeight: 'bold', color:"#999" }}>프리미엄</div>
            </div>
            <div style={{ width: 80, height: 90, display: 'inline-block', margin: '0 14px', cursor: 'pointer' }} onClick={() => window.location.href = "/sanmoz"}>
                <i className="bi bi-pencil" style={{ fontSize: 50, color:"#ff578b" }}></i>
                <div style={{ fontSize: 16, fontWeight: 'bold', color:"#ff578b" }}>산모즈</div>
            </div>
            <div style={{ width: 80, height: 90, display: 'inline-block', margin: '0 14px', cursor: 'pointer' }} onClick={() => window.location.href = "/helper_myPage"}>
                <i className="bi bi-person-circle" style={{ fontSize: 50, color:"#999" }}></i>
                <div style={{ fontSize: 16, fontWeight: 'bold', color:"#999" }}>마이페이지</div>
            </div>
        </div>
    );
}

export default Mfooter;

