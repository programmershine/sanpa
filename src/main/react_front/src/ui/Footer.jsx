import React from "react";

const Footer = (props) => {
    return (

        <div style={{
            zIndex: 251,
            position: "absolute",
            bottom: "0px",
            width: "480px",
            height: "100px",
            background: "white",
            boxShadow: "0 0 4px 4px #ccc",
            fontFamily: "'Pretendard', sans-serif", // Pretendard 폰트 패밀리 적용
        }}>
            <div style={{
                width: "80px",
                height: "90px",
                display: "inline-block",
                margin: "0 14px",
                fontSize: "16px"
            }}>
                <i className="bi bi-clipboard2-check" style={{fontSize: "50px", color: props.color1 }}></i>
                <div style={{color: props.color1, fontWeight: "bold"}}>검진일지</div>
            </div>
            <div style={{
                width: "80px",
                height: "90px",
                display: "inline-block",
                margin: "0 14px",
                fontSize: "16px"
                  }}
                 onClick={() => {
                     window.location.href = '/#/helpers';
                 }}
                 >
                <i className="bi bi-people" style={{fontSize: "50px", color: props.color2}}></i>
                <div style={{color: props.color2, fontWeight: "bold"}}>헬퍼즈</div>
            </div>
            <div onClick={() => {window.location.href='mother_daily_report';}} style={{
                width: "80px",
                height: "90px",
                display: "inline-block",
                margin: "0 14px",
                fontSize: "16px"
            }}>
                <i className="bi bi-pencil" style={{fontSize: "50px", color: props.color3}}></i>
                <div style={{color: props.color3, fontWeight: "bold"}}>오늘의상태</div>
            </div>
            <div onClick={() => {
                window.location.href = 'mother_myPage';
            }} style={{
                width: "80px",
                height: "90px",
                display: "inline-block",
                margin: "0 14px",
                fontSize: "16px"
            }}>
                <i className="bi bi-person-circle" style={{fontSize: "50px", color: props.color4}}></i>
                <div style={{color: props.color4, fontWeight: "bold"}}>마이페이지</div>
            </div>
        </div>
    );
}

export default Footer;
