import 'src/app/globals.css';

import Vault from "@/components/vault";

export default function Multichain() {
    return (
        <div className=''>
            <Vault title="ETH" fee="0.05" APR="0.08%" />
        </div>
    )
}